<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata"
    xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="atom m d xsl">
    
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes" omit-xml-declaration="no"
        media-type="application/xml" encoding="UTF-8" />
    
    <xsl:template match="/">
        <n0:CodCmSalesorderSearchResponse  xmlns:n0="http://sap.com/xi/CODERINT" xmlns:prx="urn:sap.com:proxy:L9Q:/1SAI/TASF2C09162BBB12C5DA943:804"  xmlns:soap-env="http://schemas.xmlsoap.org/soap/envelope/">
            
            <!-- Creating Sales Order Header by grouping on same Sales Order Number --> 
            
            <xsl:for-each-group select="/atom:feed/atom:entry"
                group-by="atom:content/m:properties/d:Sales_Order_No">
                
                <SalesOrderHeaders>
                    <DocNumber>
                        <xsl:value-of select="atom:content/m:properties/d:Sales_Order_No" />
                    </DocNumber>
                    <PurchNo>
                        <xsl:value-of select="atom:content/m:properties/d:Customer_PurchaseOrder" />
                    </PurchNo>
                    <DocType>
                        <xsl:value-of select="atom:content/m:properties/d:Order_Type" />
                    </DocType>
                    <CreatedBy>
                        <xsl:value-of select="atom:content/m:properties/d:Created_By" />
                    </CreatedBy>
                    <SalesOrg>
                        <xsl:value-of select="atom:content/m:properties/d:Sales_Organization"/>
                    </SalesOrg>
                    <DistributionChannel>
                        <xsl:value-of select="atom:content/m:properties/d:Distribution_Channel"/>
                    </DistributionChannel>    
                    <Division>
                        <xsl:value-of select="atom:content/m:properties/d:Division"/>
                    </Division>
                    <BusArea>a</BusArea>
                    <PurchDate>6</PurchDate>
                    <SalesGrp>32</SalesGrp>
                    <SalesOff>3</SalesOff>
                    <DistrChan>6</DistrChan>
                    <RefDoc>1</RefDoc>
                    <Orderid>a1</Orderid>
                    <RecDate>a</RecDate>                    
                    <RecTime>a</RecTime>
                    <CreatedBy>a</CreatedBy>                  
                    <SoldTo>a</SoldTo>                 
                    <SoldToNameLast>a</SoldToNameLast>
                    <SoldToNameFirst>a</SoldToNameFirst>
                    <!-- Max Length: 20 -->
                    <DocTypeDescitpion>a</DocTypeDescitpion>
                    <!-- Max Length: 10 -->
                    <NumPayCa>a</NumPayCa>
                    <!-- Max Length: 40 -->
                    <CreatedByLast>a</CreatedByLast>
                    <!-- Max Length: 40 -->
                    <CreatedByFirst>a</CreatedByFirst>
                    <!-- Max Length: 10 -->
                    <LogicalSystem>a</LogicalSystem>
                    <!-- Max Length: 3 -->
                    <Inco1>a</Inco1>
                    <!-- Max Length: 28 -->
                    <Inco2>a</Inco2>
                    <!-- Max Length: 4 -->
                    <Zterm>a</Zterm>
                    <!-- Max Length: 40 -->
                    <Inco1Text>a</Inco1Text>
                    <!-- Max Length: 40 -->
                    <Inco2Text>a</Inco2Text>
                    <!-- Max Length: 40 -->
                    <ZtermText>a</ZtermText>                 
                </SalesOrderHeaders>
                
                <!-- Creating Sales Order Item --> 
                
                <xsl:for-each select="/atom:feed/atom:entry/atom:content/m:properties/d:Sales_Order_No[../d:Sales_Order_No = current-grouping-key()]">
                    <SalesOrderItems>
                        
                        <DocNumber>
                            <xsl:value-of select="../d:Sales_Order_No" />
                        </DocNumber>
                        <ItemNumber>
                            <xsl:value-of select="../d:Item_Number" />
                        </ItemNumber>
                        <PurchNo>
                            <xsl:value-of select="../d:Customer_PurchaseOrder" />
                        </PurchNo>   
                        <DocType>
                            <xsl:value-of select="../d:Order_Type" />
                        </DocType>
                        <CreatedBy>
                            <xsl:value-of select="../d:Created_By" />
                        </CreatedBy>
                        <SalesOrg>
                            <xsl:value-of select="../d:Sales_Organization"/>
                        </SalesOrg>
                        <DistributionChannel>
                            <xsl:value-of select="../d:Distribution_Channel"/>
                        </DistributionChannel>    
                        <Division><xsl:value-of select="../d:Division"/></Division>
                        <MaterialNumber><xsl:value-of select="../d:Material_Number"/></MaterialNumber>
                        <ShortText><xsl:value-of select="../d:Item_Text"/></ShortText>
                        <Quantity><xsl:value-of select="../d:Order_Quantity"/></Quantity>
                        <OrderUnit><xsl:value-of select="../d:Order_Unit"/></OrderUnit>
                        <NetValue><xsl:value-of select="../d:Net_Value"/></NetValue>
                        <Currency><xsl:value-of select="../d:Currency"/></Currency>
                        <OverallStat><xsl:value-of select="../d:Overall_Status"/></OverallStat>
                        <DeliveryStat><xsl:value-of select="../d:Delivery_Status"/></DeliveryStat>
                        <PricingDate><xsl:value-of select="../d:Pricing_Date"/></PricingDate>
                        <BillingDate><xsl:value-of select="../d:Billing_Date"/></BillingDate>
                        <TaxAmount>1</TaxAmount>
                        <!-- Max Length: 22 -->
                        <CustMat22>a</CustMat22>
                        <!-- Max Length: 5 -->
                        <Currency>1</Currency>
                        <!-- maximum number of digits: 13, fraction digits: 0 -->
                        <Quantity>1</Quantity>
                        <!-- Max Length: 10 -->
                        <LogicalSystem>EMX</LogicalSystem>
                        <!-- Max Length: 10, Pattern: \d\d\d\d-\d\d-\d\d -->
                        <PricingDate>2018-02-22</PricingDate>
                        <!-- Max Length: 10, Pattern: \d\d\d\d-\d\d-\d\d -->
                        <BillingDate>2018-02-22</BillingDate>
                        <!-- maximum number of digits: 15, fraction digits: 0 -->
                        <GrossWeig>1</GrossWeig>
                        <!-- maximum number of digits: 15, fraction digits: 0 -->
                        <NetWeight>1</NetWeight>
                        <!-- Max Length: 3 -->
                        <UnitOfWt>1</UnitOfWt>
                        <!-- Max Length: 3 -->
                        <UnitWtiso>1</UnitWtiso>
                        <!-- maximum number of digits: 15, fraction digits: 0 -->
                        <Volume>1</Volume>
                        <!-- Max Length: 3 -->
                        <Volumeunit>a</Volumeunit>
                        <!-- Max Length: 3 -->
                        <Volunitiso>a</Volunitiso>
                        <!-- Max Length: 1 -->
                        <DeliveryStat>D</DeliveryStat>
                        <!-- Min Lenght: 1 -->
                        <OverallStat>D</OverallStat>
                        <!-- Max Length: 40 -->
                        <DeliveryStatT>D</DeliveryStatT>
                        <!-- Max Length: 40 -->
                        <OverallStatT>D</OverallStatT>
                        <!-- optional -->
                        <AccountID>112</AccountID>
                        <!-- optional -->
                        <TicketID>112</TicketID>
                        <!-- optional -->
                        <DocumentType>1</DocumentType>
                        <!-- optional -->
                        <SalesOrganisation>112</SalesOrganisation>
                        <!-- optional -->
                        <DistributionChannel>1</DistributionChannel>
                        <!-- optional -->
                        <Division>1</Division>
                        <!-- optional -->
                        <ProductID>112</ProductID>
                        <!-- optional -->
                        <Quality>1</Quality>
                        <!-- optional -->
                        <RequestedStartDate>2018-02-22</RequestedStartDate>
                    </SalesOrderItems>
                </xsl:for-each>
                
            </xsl:for-each-group>
        </n0:CodCmSalesorderSearchResponse>
    </xsl:template>
    
    
    
    <!-- Default templates to do nothing -->
    <!-- ########## -->
    <xsl:template match="text()" priority="-100"/>
    
</xsl:stylesheet>