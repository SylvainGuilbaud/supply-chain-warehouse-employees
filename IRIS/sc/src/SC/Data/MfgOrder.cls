/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture datya related to a manufacturing or work order. A manufacturing order
/// is typically a work order for some product or services, to be executed at a specified facility, with some
/// milestone dates. A manufacturing order can be associated with a sales order, if a sales order requires
/// some manufacturing process, assembling, or packaging. 
Class SC.Data.MfgOrder Extends SC.Core.Data.MfgOrder
{

Storage Default
{
<Data name="MfgOrderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>recordCreatedTime</Value>
</Value>
<Value name="3">
<Value>lastUpdatedTime</Value>
</Value>
<Value name="4">
<Value>workDescription</Value>
</Value>
<Value name="5">
<Value>orderStatus</Value>
</Value>
<Value name="6">
<Value>orderEntryDate</Value>
</Value>
<Value name="7">
<Value>workLocationId</Value>
</Value>
<Value name="8">
<Value>salesOrderId</Value>
</Value>
<Value name="9">
<Value>salesOrderLineNumber</Value>
</Value>
<Value name="10">
<Value>productId</Value>
</Value>
<Value name="11">
<Value>quantity</Value>
</Value>
<Value name="12">
<Value>unitOfMeasure</Value>
</Value>
<Value name="13">
<Value>plannedStartDate</Value>
</Value>
<Value name="14">
<Value>plannedEndDate</Value>
</Value>
<Value name="15">
<Value>actualStartDate</Value>
</Value>
<Value name="16">
<Value>actualEndDate</Value>
</Value>
<Value name="17">
<Value>notes</Value>
</Value>
<Value name="18">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.MfgOrderD</DataLocation>
<DefaultData>MfgOrderDefaultData</DefaultData>
<ExtentSize>4862</ExtentSize>
<IdLocation>^SC.Data.MfgOrderD</IdLocation>
<IndexLocation>^SC.Data.MfgOrderI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3.9</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(41,153,645,1288,1513,1836,1966,2003,2305,3046,3287,3552,3819,4065,4542,4589),$lb(0,0,0,1,1,1,0,1,0,1,1,1,0,1,2),$lb(875626496,875626496,825570048,825570048,909391104,909391104,825374776,842545152,892416768,892416768,942880256,942880256,959854080,825833014,842018867,808465152,858797312,842215477,858797110,808728064,842544896,842544896,892678656,892678656,942749952,859320633,875574837,808858880,892613120,875692032,943259648,875903033))</Histogram>
<Selectivity>1</Selectivity>
</Property>
<Property name="actualEndDate">
<AverageFieldSize>21</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb("2023-01-02 11:40:23","2023-01-02 12:25:20","2023-01-02 14:59:45","2023-01-02 15:06:14","2023-01-02 16:14:51","2023-01-02 16:39:48","2023-01-03 09:49:11","2023-01-03 10:11:40","2023-01-03 10:35:14","2023-01-03 11:08:58","2023-01-03 15:18:12","2023-01-03 15:27:51","2023-01-16 16:32:20","2023-01-16 16:56:30","2023-01-17 10:25:58","2023-01-17 10:50:18"),$lb(12,12,12,12,14,9,11,14,12,12,14,8,14,9,14),$lb(842019379,825898032,842674741,842674741,876229945,876229945,893005878,893005878,909783348,825506357,859388468,840970550,857747513,809056820,825244209,825309748,859126321,809120565,825897016,825897016,893006136,825768497,842480181,808656945,825630769,858929714,892746291,908079414,924856624,842349109,892353073,842019379))</Histogram>
<OutlierSelectivity>.009434:"2023-01-02 16:15:44"</OutlierSelectivity>
<Selectivity>0.0384%</Selectivity>
</Property>
<Property name="actualStartDate">
<AverageFieldSize>21</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb("2023-01-02 11:37:44","2023-01-02 12:23:00","2023-01-02 14:57:55","2023-01-02 15:03:37","2023-01-02 16:12:53","2023-01-02 16:38:04","2023-01-03 09:47:19","2023-01-03 10:09:20","2023-01-03 10:32:56","2023-01-03 11:07:01","2023-01-03 15:17:21","2023-01-03 15:25:32","2023-01-16 16:30:25","2023-01-16 16:55:11","2023-01-17 10:23:45","2023-01-17 10:47:35"),$lb(12,12,12,12,14,9,11,14,12,12,14,8,14,9,14),$lb(842019379,825897783,842674739,842674739,876229943,876229943,893005875,893005875,909783346,825375285,859322928,840970550,857747513,809056820,825244208,809056818,858929717,809120562,825897015,825897015,893006135,825702962,842349107,808656945,825630769,858798642,892680753,908079414,924856624,842218036,876034611,842019379))</Histogram>
<OutlierSelectivity>.009434:"2023-01-03 10:10:01"</OutlierSelectivity>
<Selectivity>0.0293%</Selectivity>
</Property>
<Property name="lastUpdatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb("2025-04-04 11:00:18.419","2025-04-04 11:00:19.129","2025-04-04 11:00:22.691","2025-04-04 11:00:26.972","2025-04-04 11:00:32.421","2025-04-04 11:00:34.923","2025-04-04 11:00:35.958","2025-04-04 11:00:36.258","2025-04-04 11:00:38.190","2025-04-04 11:00:43.151","2025-04-04 11:00:45.030","2025-04-04 11:00:47.153","2025-04-04 11:00:49.066","2025-04-04 11:00:50.824","2025-04-04 11:00:54.038","2025-04-04 11:00:54.337"),$lb(18,17,18,17,18,18,18,18,17,18,18,18,17,18,20),$lb(842019381,942552113,959328562,825830961,842149430,841889337,908998967,842411577,858926644,841888818,875444530,875444530,892221749,892221749,908997173,908997173,942551353,859319857,875769393,858665269,892219443,892219443,925774133,925774133,959328310,876162608,892350008,808335410,875442227,808663040,858994432,842019381))</Histogram>
<Selectivity>0.0206%</Selectivity>
</Property>
<Property name="notes">
<AverageFieldSize>6.51</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" EMP1"," EMP10"," EMP11"," EMP13"," EMP14"," EMP2"," EMP26"," EMP27"," EMP29"," EMP3"," EMP30"," EMP4"," EMP6"," EMP7"," EMP9"," EMP9"),$lb(5,5,5,5,4,5,5,5,4,5,4,4,4,4,6),$lb(541412688,0,805306368,805306368,822083584,822083584,855638016,855638016,872415232,825491456,838860800,0,905969664,905969664,922746880,922746880,956301312,842596352,855638016,0,805306368,858783744,872415232,872415232,905969664,905969664,922746880,922746880,956301312,0,0,541412688))</Histogram>
<Selectivity>4.5116%</Selectivity>
</Property>
<Property name="orderEntryDate">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="orderStatus">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "),$lb(2,2,2,2,2,2,2,2,2,2,2,2,2,2,2),$lb(536870912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,536870912))</Histogram>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="plannedEndDate">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="plannedStartDate">
<AverageFieldSize>21</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" 2023-01-02 11:37:44"," 2023-01-02 12:23:00"," 2023-01-02 14:57:55"," 2023-01-02 15:03:37"," 2023-01-02 16:12:53"," 2023-01-02 16:38:04"," 2023-01-02 18:44:44"," 2023-01-02 19:41:52"," 2023-01-02 21:35:31"," 2023-01-03 10:01:55"," 2023-01-03 15:17:21"," 2023-01-03 15:25:32"," 2023-01-15 17:50:43"," 2023-01-15 18:50:10"," 2023-01-16 12:20:20"," 2023-01-16 14:13:09"),$lb(13,13,13,13,15,13,13,12,10,13,15,9,13,10,13),$lb(540160050,825897783,842674739,842674739,876229943,876229943,893005875,893005875,909783346,825375285,859322928,909783864,943338548,943338548,960115761,825834036,842086963,840970801,857747760,809119793,893006135,825702962,842349107,808656945,825565233,926561584,943338800,891302200,908079410,842674736,876228915,540160050))</Histogram>
<Selectivity>0.0206%</Selectivity>
</Property>
<Property name="productId">
<AverageFieldSize>17</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" LABORPRODUCT-01"," LABORPRODUCT-03"," LABORPRODUCT-03"," LABORPRODUCT-03"," LABORPRODUCT-03"," LABORPRODUCT-03"," LABORPRODUCT-03"," LABORPRODUCT-03"," LABORPRODUCT-03"," LABORPRODUCT-03"," LABORPRODUCT-03"," LABORPRODUCT-03"," LABORPRODUCT-03"," LABORPRODUCT-03"," LABORPRODUCT-03"," LABORPRODUCT-03"),$lb(15,17,17,17,17,17,17,17,17,17,17,17,17,17,17),$lb(541868354,822083584,855638016,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,541868354))</Histogram>
<OutlierSelectivity>.985849:"laborproduct-03"</OutlierSelectivity>
<Selectivity>1.4151%</Selectivity>
</Property>
<Property name="quantity">
<AverageFieldSize>3.02</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(40,66,81,87,93,98,103,107,112,119,128,132,139,148,172,2628),$lb(0,0,1,0,1,0,2,1,2,1,1,2,1,1,0),$lb(875560960,875560960,909508608,909508608,942735360,822083584,922746880,943128576,959643648,855638016,939524096,959971328,825242368,855638016,922746880,808910848,825360384,838860800,956301312,825819136,842530816,842530816,858914816,838860800,956301312,859373568,876085248,876085248,926023680,825700864,842412600,842412600))</Histogram>
<Selectivity>0.7415%</Selectivity>
</Property>
<Property name="recordCreatedTime">
<AverageFieldSize>24.91</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb("2025-04-04 11:00:18.419","2025-04-04 11:00:19.129","2025-04-04 11:00:22.691","2025-04-04 11:00:26.972","2025-04-04 11:00:32.421","2025-04-04 11:00:34.923","2025-04-04 11:00:35.957","2025-04-04 11:00:36.258","2025-04-04 11:00:38.19","2025-04-04 11:00:43.151","2025-04-04 11:00:45.03","2025-04-04 11:00:47.152","2025-04-04 11:00:49.066","2025-04-04 11:00:50.824","2025-04-04 11:00:54.038","2025-04-04 11:00:54.337"),$lb(18,17,18,17,18,18,18,18,17,18,18,18,17,18,20),$lb(842019381,942552113,959328562,825830961,842149430,841889337,908998967,842411577,858926644,841888818,875444530,875444530,892221749,892221749,908997173,908997173,942551353,859319857,875769393,858665269,892219443,892219443,925774133,925774133,959328310,876162608,892350008,808335410,875442227,808663040,858994432,842019381))</Histogram>
<Selectivity>0.0206%</Selectivity>
</Property>
<Property name="salesOrderId">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "),$lb(2,2,2,2,2,2,2,2,2,2,2,2,2,2,2),$lb(536870912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,536870912))</Histogram>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="salesOrderLineNumber">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "),$lb(2,2,2,2,2,2,2,2,2,2,2,2,2,2,2),$lb(536870912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,536870912))</Histogram>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="uid">
<AverageFieldSize>38</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="unitOfMeasure">
<AverageFieldSize>9</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" SECONDS"," SECONDS"," SECONDS"," SECONDS"," SECONDS"," SECONDS"," SECONDS"," SECONDS"," SECONDS"," SECONDS"," SECONDS"," SECONDS"," SECONDS"," SECONDS"," SECONDS"," SECONDS"),$lb(9,9,9,9,9,9,9,9,9,9,9,9,9,9,9),$lb(542328131,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,542328131))</Histogram>
<OutlierSelectivity>.999999:"seconds"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="workDescription">
<AverageFieldSize>6.07</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" PICK"," PICK"," PICK"," PICK"," PICK"," PICK"," PICK"," PICK"," PICK"," PICK"," PICK"," PICK"," PICK"," PICK"," PICK"," STORAGE"),$lb(6,6,6,6,6,6,6,6,6,6,6,6,6,6,1),$lb(542132547,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1346978635,1398034258,542331983))</Histogram>
<OutlierSelectivity>.976415:"Pick"</OutlierSelectivity>
<Selectivity>1.1792%</Selectivity>
</Property>
<Property name="workLocationId">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "),$lb(2,2,2,2,2,2,2,2,2,2,2,2,2,2,2),$lb(536870912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,536870912))</Histogram>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-572</BlockCount>
</SQLMap>
<SQLMap name="productIdIndex">
<BlockCount>-28</BlockCount>
</SQLMap>
<SQLMap name="salesOrderIdIndex">
<BlockCount>-32</BlockCount>
</SQLMap>
<SQLMap name="uidIndex">
<BlockCount>-160</BlockCount>
</SQLMap>
<SQLMap name="workLocationIdIndex">
<BlockCount>-24</BlockCount>
</SQLMap>
<StreamLocation>^SC.Data.MfgOrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
