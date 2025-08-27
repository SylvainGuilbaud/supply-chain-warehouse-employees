Class SC.Core.Util.rebuildIndices Extends %RegisteredObject
{

ClassMethod rebuildIndices() As %Status
{
    set query = "select name from %Dictionary.CompiledClass where ClassType = 'persistent' and SqlSchemaName = 'SC_Data'"
    set rs = ##class(%SQL.Statement).%ExecDirect(,query)

    if rs.%SQLCODE < 0 {
        set sc = $$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message)
        $$$ThrowStatus(sc)
    }
    while rs.%Next() {
        set className = rs.%Get("name")
        #; write !,"Class Name is: ", className
        set sc = $CLASSMETHOD(className,"%BuildIndices")
        if $$$ISOK(sc) {
            // Continue
            write !,"Successfully rebuilt indices for object ",className,". "
        }
        else {
            write !,"Failed to rebuild indices for object ",className,". "
            $$$ThrowOnError(sc)
        }
    }
    return $$$OK
}

}
