/// 
Class SC.Core.Analytics.Cube.LaborDeficitCube Extends %DeepSee.CubeDefinition [ DependsOn = SC.Core.Data.Internal.LaborDeficit, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="LaborDeficitCube" displayName="LaborDeficitCube" disabled="false" abstract="false" sourceClass="SC.Core.Data.Internal.LaborDeficit" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="locationId" disabled="false" hasAll="false" allCaption="All locationId" allDisplayName="locationId" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="locationId" disabled="false" sourceProperty="locationId" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="productId" disabled="false" hasAll="false" allCaption="All productId" allDisplayName="productId" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="productId" disabled="false" sourceProperty="productId" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="startDate" disabled="false" hasAll="false" allCaption="All startDate" allDisplayName="startDate" sourceProperty="startDate" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="startDate" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="status" disabled="false" hasAll="false" allCaption="All status" allDisplayName="status" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" disabled="false" sourceProperty="quantity" list="false" rangeExpression="(,-80]:Understaffed;(-80,120]:Staffed;(120,):Overstaffed;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="combinedStatus" disabled="false" hasAll="false" allCaption="All New_dataDimension1" allDisplayName="New_dataDimension1" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="combinedStatus" disabled="false" sourceProperty="quantity" list="false" rangeExpression="(,-80]:Misstaffed;(-80,120]:Staffed;(120,):Misstaffed;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="6">
      </level>
    </hierarchy>
  </dimension>
  <measure name="quantity" disabled="false" sourceProperty="quantity" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="1">
  </measure>
  <measure name="supplyQuantity" disabled="false" sourceProperty="supplyQuantity" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="2">
  </measure>
  <measure name="demandQuantity" disabled="false" sourceProperty="demandQuantity" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="3">
  </measure>
  <listing name="LaborDeficitListing" disabled="false" listingType="table" fieldList="productId,locationId,startDate,quantity" selectMode="2">
  </listing>
</cube>
}

Parameter DOMAIN;

}
