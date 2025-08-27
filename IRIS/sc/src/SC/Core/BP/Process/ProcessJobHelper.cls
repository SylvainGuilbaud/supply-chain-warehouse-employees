Class SC.Core.BP.Process.ProcessJobHelper
{

/// Upload Data
ClassMethod LoadData(fileType As %String, tableName As %String, uploadType As %String, mappingType As %String, attributeList As %String, idList As %String, fileAddr As %String, uid As %String, formatList As %String, dateTimeList As %String, receivedTime As %DateTime, defaultTimezone As %String, delimiter As %String, hasHeaderRow As %String, mappingTypeList As %String, defaultValueList As %String, delimiterList As %String, transformationList As %String, indexList As %String, uidAutoGeneration As %String) As %Status
{

    Set sc = $$$OK

    set sql = ""
    set sqlEnd = ""
    set uidIndex= ""
    // Extract uid from the list and store
    set listAttributeList = $LISTFROMSTRING(attributeList)
    set uidIndex = $LISTFIND(listAttributeList, "uid")

    // Create beginning of SQL statements
    if uploadType = "insert"{
        set sql = "INSERT INTO "
    }elseif uploadType = "update"{
        set sql = "UPDATE "

        set status = ..RemoveUidFromLists(uidIndex, .attributeList, .idList, .mappingTypeList, .delimiterList, .transformationList, .indexList, .formatList, .dateTimeList, .defaultValueList)

        set sqlEnd = " WHERE uid = "

    }elseif uploadType = "upsert"{
        set sql = "INSERT OR UPDATE "

    }


    set sql = sql_tableName
    // call upload method
    if fileType="csv"{
        set sc =  ..DataIterator(sql, idList, fileAddr, mappingType, uid, sqlEnd, uidIndex, tableName, " ("_attributeList_") ", 
                                 formatList, dateTimeList, receivedTime, defaultTimezone, delimiter, hasHeaderRow, mappingTypeList, 
                                 defaultValueList, delimiterList, transformationList, indexList, uidAutoGeneration)
    }

    Return sc
}

/// Update list in the case of an update to remove uid parameters
ClassMethod RemoveUidFromLists(uidIndex As %Numeric, ByRef attributeList As %String, ByRef idList As %String, ByRef mappingTypeList As %String, ByRef delimiterList As %String, ByRef transformationList As %String, ByRef indexList As %String, ByRef formatList As %String, ByRef dateTimeList As %String, ByRef defaultValueList As %String) As %Status
{
    Set sc = $$$OK

    set attributeList = $REPLACE(attributeList, "uid,", "")
    set idListList = $LISTFROMSTRING(idList)
    set idListList = $LISTUPDATE(idListList, uidIndex, "")
    set idList = $LISTTOSTRING(idListList)
    set idList = $ZSTRIP(idList, "<", ", ")
    set idList = $REPLACE(idList, ", ,", ",")

    set uidMappingType = $PIECE(mappingTypeList, ", ", uidIndex)
    set uidDelimiter = $PIECE(delimiterList, ", ", uidIndex)
    set uidTransformation = $PIECE(transformationList, ", [", uidIndex)



    set transformationList = $REPLACE(transformationList, uidTransformation, "", uidIndex, uidIndex)
    set transformationList = $REPLACE(transformationList, ", [", "", uidIndex, uidIndex)

    set indexList = $REPLACE(indexList, ", ", "", uidIndex, uidIndex)

    set formatList = $REPLACE(formatList, ", ", "", uidIndex, uidIndex)
    set dateTimeList = $REPLACE(dateTimeList, ", ", "", uidIndex, uidIndex)
    set mappingTypeList = $REPLACE(mappingTypeList, uidMappingType, "", uidIndex, uidIndex)
    set mappingTypeList = $REPLACE(mappingTypeList, ", ", "", uidIndex, uidIndex)

    set defaultValueList = $REPLACE(defaultValueList, ", ", "", uidIndex, uidIndex)
    set delimiterList = $REPLACE(delimiterList, uidDelimiter, "", uidIndex, uidIndex)
    set delimiterList = $REPLACE(delimiterList, ", ", "", uidIndex, uidIndex)


    Return sc
}

/// Iterate and upload data
ClassMethod DataIterator(sql As %String, idList As %String, fileAddr As %String, mappingType As %String, uid As %String, sqlEnd As %String, uidVal As %String, tableName As %String, keys As %String, formatList As %String, dateTimeList As %String, receivedTime As %DateTime, defaultTimezone As %String, delimiter As %String, hasHeaderRow As %String, mappingTypeList As %String, defaultValueList As %String, delimiterList As %String, transformationList As %String, indexList As %String, uidAutoGeneration As %String) As %Status
{
    Set sc = $$$OK

    Set totalRecords = 0
    Set recordsUpdated = 0
    Set recordsFailed = 0
    set recordsCreated = 0

    try{
        // move upload status to in progress
        set update = "UPDATE SC_Core_Data_Internal.BulkUpload "_
                    "(status, startTime) "_
                    "VALUES ('in progress', '"_$ZDATETIME($ZTIMESTAMP, 3, 1, 3)_"') "_
                    "WHERE uid = '"_uid_"'"

        set tStatement = ##class(%SQL.Statement).%New()

        set sc = tStatement.%Prepare(update)
        if $$$ISERR(sc){
           set exception = ##class(%Exception.StatusException).CreateFromStatus(sc)
           set exception.Name = "SQL Prepare error "
           throw exception
        }


        set rset = tStatement.%Execute()
        if rset.%SQLCODE<0{
            set sc = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)
            set exception = ##class(%Exception.StatusException).CreateFromStatus(sc)
            set exception.Name = "SQL Execute error "
            throw exception
        }

        // convert file to character stream
        set str = ##class(%Stream.FileCharacter).%New()
        set sc =  str.LinkToFile(fileAddr)
        if $$$ISERR(sc){
           set exception = ##class(%Exception.StatusException).CreateFromStatus(sc)
           set exception.Name = "Error linking to file "_fileAddr
           throw exception
        }

        // if the mapping are strings, convert to numbers
        if mappingType = "Strings"{

            set tempIdList = ""
            set row = $ZSTRIP(str.ReadLine(), ">C")
            set sc = ..ReformatLine(.row, delimiter, .results)
            if $$$ISERR(sc){
                set exception = ##class(%Exception.StatusException).CreateFromStatus(sc)
                set exception.Name = "Error reformatting header"
                throw exception
            }

            set headersList = $LISTFROMSTRING(row, delimiter)
            set ptr=0
            set tempList = ""
            set delimiterCountList = ""
            while $LISTNEXT(headersList,ptr,value) {

                set tempVal = results.GetAt(value)            

                set:tempVal'="" value = tempVal
                set count = $LENGTH(value,delimiter)
                if delimiterCountList = ""{
                    set delimiterCountList = delimiterCountList_count
                }else{
                    set delimiterCountList = delimiterCountList_","_count
                }
                set tempList = tempList _$LISTBUILD(value)         

            }
            set headersList = tempList


            set i = 1

            // iterate over header and convert to index
            while $PIECE(idList, ", ", i)'=""{
                if tempIdList '=""{
                    set tempIdList = tempIdList_", "
                }

                set val = $PIECE(idList, ", ", i)
                set location = $LISTFIND(headersList, val)
                if location = 0{
                    set exception = ##class(%Exception.General).%New("Header not found in file "_val)
                    throw exception
                }

                set tempIdList = tempIdList_location
                set i = i+$PIECE(delimiterCountList, ",", location)
            }

            set idList = tempIdList

        } elseif (hasHeaderRow = "true"){
            do str.ReadLine()
        }

        set count = 0
        set sc = ..RowCount(tableName, .count)
        
        if $$$ISERR(sc){
           set exception = ##class(%Exception.StatusException).CreateFromStatus(sc)
           set exception.Name = "Error getting number of rows from table"
           throw exception
        }

        // iterate over the string by lines
        while 'str.AtEnd{
            set tempKey = keys
            set lineOriginal = $ZSTRIP(str.ReadLine(), ">C")
            set line = lineOriginal

            // remove commas to parse correctly
            set stat = ..ReformatLine(.line, delimiter, .replacements)
            if $$$ISERR(stat){
                set sc = ..StoreRowError(.recordsFailed, .totalRecords, uid, "Reformat line failed", lineOriginal)
                if $$$ISERR(sc){
                    set exception = ##class(%Exception.StatusException).CreateFromStatus(sc)
                    set exception.Name = "Error storing row error "
                    throw exception
                }
            }
            set i = 1
            set dataStr = ""


            // iterate over columns 
            while $PIECE(mappingTypeList, ", ", i)'=""{

                if dataStr '=""{
                    set dataStr = dataStr_", "
                }
                set currentVal = ""

                set mappingVersion = $PIECE(mappingTypeList, ", ", i)

                if mappingVersion = "aggregation"{
                    set currentVal = ..AggregateData(line, $PIECE(indexList, ", ", i), delimiter, $PIECE(delimiterList, ", ", i), replacements)
                }
                elseif mappingVersion = "uid"{
                    set currentVal = ..GenerateUID(uid, totalRecords+1)
                }
                else{
                    // create list of current values
                    set idx = $NUMBER($PIECE(idList, ",", i))
                    set currentVal = $PIECE(line, delimiter, idx)

                    // remove any unset elements
                    if currentVal = ""{
                        if (sqlEnd="") && (i = uidVal) && (uidAutoGeneration = "true"){
                            set currentVal = ..GenerateUID(uid, totalRecords+1)
                        }
                        elseif $PIECE(defaultValueList, ", ", i)'=""{
                            set currentVal = $PIECE(defaultValueList, ", ", i)
                        }
                        else{
                            // if at the end, keep a close parenthesis
                            if i = $LENGTH(tempKey, ","){
                                set $PIECE(tempKey, ",", i) = ")"
                            }else{
                                set $PIECE(tempKey, ",", i) = ""
                            }
                        }
                    }
                    else{
                        if mappingVersion = "transformation"{
                            set stat = ..TransformData(.currentVal, $REPLACE($PIECE(transformationList, ", [", i), "]", "",-1)_"]")
                            if $$$ISERR(stat){
                                set sc = ..StoreRowError(.recordsFailed, .totalRecords, uid, "Transform data failed", lineOriginal)
                                if $$$ISERR(sc){
                                    set exception = ##class(%Exception.StatusException).CreateFromStatus(sc)
                                    set exception.Name = "Error storing row error "
                                    throw exception
                                }


                            }
                        }
                        else{
                            set status =  ..DirectDataTranformation($PIECE(formatList, ", ", i), .currentVal, $PIECE(dateTimeList, ", ", i), defaultTimezone, replacements)
                            if $$$ISERR(status){
                                set sc = ..StoreRowError(.recordsFailed, .totalRecords, uid, "Direct data transformation failed", lineOriginal)
                                if $$$ISERR(sc){
                                    set exception = ##class(%Exception.StatusException).CreateFromStatus(sc)
                                    set exception.Name = "Error storing row error"
                                    throw exception
                                }
                            }
                        }
                    }
                }

                set dataStr = dataStr_" '"_currentVal_"'"
                set i = i+1
            }

            // if update, fix the ending of the statement
            set sqlEndTemp = ""
            if sqlEnd '=""{
                set sqlEndTemp = sqlEnd_"'"_$PIECE(line, delimiter, uidVal)_"'"

            }

            // remove any empty elements
            while $FIND(tempKey, ",,") '= 0{
                set tempKey = $REPLACE(tempKey, ",,", ",")
            }
            
            set tempKey = $REPLACE(tempKey, ",)", ")")
            set tempKey = $REPLACE(tempKey, ") ,", ")")

            while $FIND(dataStr, ",  ''") '= 0{
                set dataStr = $REPLACE(dataStr, ",  ''", "")

            }
            while $FIND(dataStr, ",  ,") '= 0{
                set dataStr = $REPLACE(dataStr, ", ,", ",")
            }

            set dataStr = $ZSTRIP(dataStr, ">", ", ")
            

            // create final sql statement and parse results
            set sqlFinal = sql_tempKey_" VALUES ("_dataStr_")"_sqlEndTemp

            set tStatement = ##class(%SQL.Statement).%New()

            set qStatus = tStatement.%Prepare(sqlFinal)

            if $$$ISERR(qStatus) {

                set sc = ..StoreRowError(.recordsFailed, .totalRecords, uid, "Prepare error: """_tempKey_"""", lineOriginal)
                if $$$ISERR(sc){
                    set exception = ##class(%Exception.StatusException).CreateFromStatus(sc)
                    set exception.Name = "Error storing row error "
                    throw exception
                }
                continue
            }

            set rset = tStatement.%Execute()
            if rset.%SQLCODE<0{
                // Update total records and failed records

                set sc = ..StoreRowError(.recordsFailed, .totalRecords, uid, rset.%SQLCODE_": "_$SYSTEM.SQL.Functions.SQLCODE(rset.%SQLCODE), lineOriginal)
                if $$$ISERR(sc){
                    set exception = ##class(%Exception.StatusException).CreateFromStatus(sc)
                    set exception.Name = "Error storing row error "
                    throw exception
                }

                continue
            }

            set totalRecords = totalRecords + 1
            set tempCount = 0
            set sc = ..RowCount(tableName, .tempCount)
            if $$$ISERR(sc){
                set exception = ##class(%Exception.StatusException).CreateFromStatus(sc)
                set exception.Name = "Error getting row count"
                throw exception
            }


            if count = tempCount{
                set recordsUpdated = recordsUpdated + 1
            }
            else{
                set recordsCreated = recordsCreated + 1
            }

            set count = tempCount

        }
        
        // Add counts and finished status to the table
        set update = "UPDATE SC_Core_Data_Internal.BulkUpload "_
            "(status, finishedTime, failedRecords, recordsCreated, recordsUpdated, totalRecords) "_
            "VALUES ('complete', '"_$ZDATETIME($ZTIMESTAMP, 3, 1, 3)_"', '"_recordsFailed_"', '"_recordsCreated_"', '"_recordsUpdated_"', '"_totalRecords_"') "_
            "WHERE uid = '"_uid_"'"

        
        set tStatement = ##class(%SQL.Statement).%New()

        set sc = tStatement.%Prepare(update)
        if $$$ISERR(sc){
            do ##class(%SYS.System).WriteToConsoleLog("Error storing success upload status", 1)

        }
        set rset = tStatement.%Execute()
        if rset.%SQLCODE<0{
            //error
            set sc = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)
            do ##class(%SYS.System).WriteToConsoleLog("Error storing success upload status", 1)


        }

        set stat =  ..SaveFile(fileAddr, receivedTime, "complete")
        set str = ""

        if $$$ISERR(stat){
            do ##class(%SYS.System).WriteToConsoleLog("Error archiving stored file. File will still be stored in processing", 1)

        }
        else{

            set stat = ##class(%File).Delete(fileAddr, .return)

            if '($$$ISERR(stat)){
                do ##class(%SYS.System).WriteToConsoleLog("Deleted file complete "_fileAddr , 1)
            }
            else{
                do ##class(%SYS.System).WriteToConsoleLog("Failed to delete file "_fileAddr, 1)

            }
        }

    } catch (ex) {
        set str = ""

        set errorMessage = ex.Name

        set update = "UPDATE SC_Core_Data_Internal.BulkUpload "_
            "(status, finishedTime, failedRecords, recordsCreated, recordsUpdated, totalRecords, errorMessage) "_
            "VALUES ('failed', '"_$ZDATETIME($ZTIMESTAMP, 3, 1, 3)_"', '"_recordsFailed_"', '"_recordsCreated_"', '"_recordsUpdated_"', '"_totalRecords_"', '"_errorMessage_"') "_
            "WHERE uid = '"_uid_"'"

        set sc = $$$OK
        set tStatement = ##class(%SQL.Statement).%New()

        set qStatus = tStatement.%Prepare(update)
        if qStatus'=1 {
            //error
            set sc = qStatus
            do ##class(%SYS.System).WriteToConsoleLog("Error storing failed upload status", 1)

        }

        set rset = tStatement.%Execute()
        if rset.%SQLCODE<0{
            //error
            set sc = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)
            do ##class(%SYS.System).WriteToConsoleLog("Error storing failed upload status", 1)

        }
        set sc =  ..SaveFile(fileAddr, receivedTime, "failed")
        if $$$ISERR(sc){
            do ##class(%SYS.System).WriteToConsoleLog("Error archiving failed file. File will still be stored in processing", 1)
        }
        else{
            set sc = ##class(%File).Delete(fileAddr)
            if '($$$ISERR(sc)){
                do ##class(%SYS.System).WriteToConsoleLog("Deleted failed file upload"_fileAddr, 1)
            }
            else{
                do ##class(%SYS.System).WriteToConsoleLog("Delete file failed for file "_fileAddr, 1)
            }
        }
    }
    Return sc
}

/// Store row errors
ClassMethod StoreRowError(ByRef recordsFailed, ByRef totalRecords, uid As %String, error As %String, lineOriginal As %String) As %Status
{
    Set sc = $$$OK
     // Update total records and failed records
    set recordsFailed = recordsFailed + 1
    set totalRecords = totalRecords + 1
    set update = "INSERT INTO SC_Core_Data_Internal.BulkUploadErrors "_
        "(uid, lineNumber, errorMessage, lineDetails) "_
        "VALUES ('"_uid_"', '"_totalRecords_"', '"_error_"', '"_lineOriginal_"') "

    set tStatement = ##class(%SQL.Statement).%New()

    set sc = tStatement.%Prepare(update)
    if $$$ISERR(sc) {
        return sc
    }

    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        //error
        set sc = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)
        return sc
    }
    Return sc
}

/// Generate unique uids
ClassMethod GenerateUID(uploadId As %String, rowNumber As %String) As %String
{
    return uploadId_"-"_rowNumber
}

/// Direct Tranformation
ClassMethod DirectDataTranformation(format As %String, ByRef currentVal As %String, dateTimeOffset As %String, defaultTimezone As %String, replacements As %ArrayOfDataTypes) As %Status
{
    set sc = $$$OK
    // Extract format and reformat the timestamp
    if format'=""{

        set currentVal = $SYSTEM.SQL.Functions.TOTIMESTAMP(currentVal,format)
        if currentVal =0{
            set sc =  $$$ERROR($$$GeneralError,"Failed to conver to timestamp")
            return sc
        }
    }
    // Need to ensure it is a date time attribute

    if dateTimeOffset'=""{
        // Extract the timezone and apply the offset
        set defaultTimezone = $REPLACE(defaultTimezone, "+", "")
        set hour = $PIECE(defaultTimezone, ":", 1)
        set minute = $PIECE(defaultTimezone, ":", 2)
        if hour < 0{
            set minute = minute * -1
        }

        set hour = -1 * hour

        set minute = -1 * minute

        set currentVal = $SYSTEM.SQL.Functions.DATEADD("hour", hour, currentVal)

        if currentVal = ""{
            set sc =  $$$ERROR($$$GeneralError, "Failed to add hours to timestamp")
            return sc
        }

        set currentVal = $SYSTEM.SQL.Functions.DATEADD("minute", minute, currentVal)
        if currentVal = ""{
            set sc = $$$ERROR($$$GeneralError, "Failed to add minutes to timestamp")
            return sc

        }
    }
    // replace any commas that were removed
    set tempVal = replacements.GetAt(currentVal)
    set:tempVal'="" currentVal = tempVal

    return sc
}

/// Create aggregate data
ClassMethod AggregateData(line As %String, mapping As %String, delimiter As %String, mappingDelimiter As %String, replacements As %ArrayOfDataTypes) As %String
{

    set result = ""
    set i = 1
    set mapping = $REPLACE(mapping, "[", "")
    set mapping = $REPLACE(mapping, "]", "")

    while $PIECE(mapping, "; ", i) '= ""{
        if result '= ""{
            set result = result_mappingDelimiter
        }

        set val = $PIECE(line, delimiter, $NUMBER($PIECE(mapping, "; ", i)))

        if val = ""{
            set i = i + 1
            continue
        }

        set temp = replacements.GetAt(val)

        set:temp'="" val = temp
        set result = result_val
        set i = i + 1

    }
    return result
}

/// Transform Data
ClassMethod TransformData(ByRef term As %String, transformation As %String) As %Status
{
    set sc = $$$OK
    set result = ""
    set transformation = ##class(%DynamicObject).%FromJSON(transformation)

    set iter = transformation.%GetIterator()
    set transformations = ##class(%ArrayOfDataTypes).%New()

    while iter.%GetNext(,.map){

        set sourceValue = map.%Get("sourceValue")
        set targetValue = map.%Get("targetValue")

        set sc = transformations.SetAt(targetValue, sourceValue)
        if $$$ISERR(sc){
            return sc
        }
    }

    set result = transformations.GetAt(term)
    if result=""{
        set result = transformations.GetAt("defaultValue")
    }
    set term = result
    return sc
}

/// Remove commas from string and replace with semicolons
ClassMethod ReformatLine(ByRef line As %String, delimiter As %String, Output replacements As %ArrayOfDataTypes) As %Status
{
    set sc = $$$OK

    set replacements = ##class(%ArrayOfDataTypes).%New()
    set i = 2
    while $PIECE(line, """", i) '=""{

        set result = $REPLACE($PIECE(line, """", i), delimiter, "")

        set sc =  replacements.SetAt($PIECE(line, """", i), result)
        if $$$ISERR(sc){
            return sc
        }
        set $PIECE(line, """", i) = result
        set i = i + 2
    }
    set line = $REPLACE(line, """", "")
    return sc
}

/// Get number of rows from table
ClassMethod RowCount(tableName, Output tempCount) As %Status
{
    set status = $$$OK
    set sql = "SELECT COUNT(*) As RowCount FROM "_tableName
    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        return qStatus
    }

    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        return $$$ERROR("SQL Failed "_rset.%SQLCODE)
    }

    Do rset.%Next()
    set tempCount = rset.%Get("RowCount")
    return status
}

/// Save file in Provided Folder
ClassMethod SaveFile(fileAddr As %String, receivedTime As %String, folder As %String) As %Status
{
    set path = ##class(SC.Core.API.Data.BulkUploadApiImpl).GeneratePath(fileAddr, receivedTime, folder)

    // move file to new location
    set status =  ##class(%File).CopyFile(fileAddr, path, 0, .return)
    return status
}

}
