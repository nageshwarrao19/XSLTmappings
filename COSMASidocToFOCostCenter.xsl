<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="xsl ValueMap java" xmlns:java="http://xml.apache.org/xslt/java" xmlns:ValueMap="com.sap.aii.mapping.value.api.XIVMService" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:strip-space elements="*"/>
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    
    <!-- XSLT Mapping to Transform COSMAS idoc into FOCostCenter Odata for SuccessFactors -->
    
    <xsl:template match="COSMAS01">
        <FOCostCenter>
            <xsl:apply-templates select="IDOC/E1CSKSM"/>
        </FOCostCenter>
    </xsl:template>
    <xsl:template match="E1CSKSM">
        <FOCostCenter>
            <externalCode>
                <xsl:value-of select="KOSTL"/>
            </externalCode>
            <startDate>
                <xsl:apply-templates select="DATAB"/>
            </startDate>
            <cust_toLegalEntityProp>
                <!-- Value Mapping for Company Code Conversion -->    
                <xsl:call-template name="ValueMapping">
                    <xsl:with-param name="CompanyCode" select="BUKRS"/>
                </xsl:call-template> 
            </cust_toLegalEntityProp>
            <endDate>
                <xsl:apply-templates select="DATBI"/>
            </endDate>
            <status>              
                <!-- Status to be 'Active' or 'InActive' based on DATBI greater/lower than current date --> 
                <xsl:call-template name="StatusDerivation">
                    <xsl:with-param name="endDate" select="DATBI"/>
                    <xsl:with-param name="startDate" select="DATAB"/>
                    <xsl:with-param name="currentDate" select="java:format(java:java.text.SimpleDateFormat.new(&apos;yyyyMMdd&apos;), java:java.util.Date.new())"/>/>
                </xsl:call-template>
            </status>
            <xsl:apply-templates select="E1CSKTM"/>     
        </FOCostCenter>      
    </xsl:template>
    
    <xsl:template match="E1CSKTM">
        <xsl:choose>
            
            <!-- Creating a name_*, description_*, based on SPRAS_ISO Code. default,EN and GB are always created for English --> 
            
            <xsl:when test="SPRAS_ISO = 'EN'">                
                <name_defaultValue>
                    <xsl:apply-templates select="KTEXT"/>
                </name_defaultValue>
                <description_defaultValue>
                    <xsl:apply-templates select="LTEXT"/>
                </description_defaultValue>
                <name_en_US>
                    <xsl:apply-templates select="KTEXT"/>
                </name_en_US>
                <name_en_GB>
                    <xsl:apply-templates select="KTEXT"/>
                </name_en_GB>
                <description_en_US>
                    <xsl:apply-templates select="LTEXT"/>
                </description_en_US>
                <description_en_GB>
                    <xsl:apply-templates select="LTEXT"/>
                </description_en_GB>
            </xsl:when>
            <xsl:when test="SPRAS_ISO = 'ES'">               
                <name_es_ES>
                    <xsl:apply-templates select="KTEXT"/>
                </name_es_ES>
                <description_es_ES>
                    <xsl:apply-templates select="LTEXT"/>
                </description_es_ES>
            </xsl:when>
            <xsl:when test="SPRAS_ISO = 'RU'">               
                <name_ru_RU>
                    <xsl:apply-templates select="KTEXT"/>
                </name_ru_RU>
                <description_ru_RU>
                    <xsl:apply-templates select="LTEXT"/>
                </description_ru_RU>
            </xsl:when>
            <xsl:when test="SPRAS_ISO = 'ZH'">               
                <name_zh_CN>
                    <xsl:apply-templates select="KTEXT"/>
                </name_zh_CN>
                <description_zh_CN>
                    <xsl:apply-templates select="LTEXT"/>
                </description_zh_CN>
            </xsl:when>
            <xsl:when test="SPRAS_ISO = 'SV'">               
                <name_sv_SE>
                    <xsl:apply-templates select="KTEXT"/>
                </name_sv_SE>
                <description_sv_SE>
                    <xsl:apply-templates select="LTEXT"/>
                </description_sv_SE>
            </xsl:when>
            <xsl:when test="SPRAS_ISO = 'FR'">               
                <name_fr_FR>
                    <xsl:apply-templates select="KTEXT"/>
                </name_fr_FR>
                <description_fr_FR>
                    <xsl:apply-templates select="LTEXT"/>
                </description_fr_FR>
            </xsl:when>
            <xsl:when test="SPRAS_ISO = 'BS'">               
                <name_bs_ID>
                    <xsl:apply-templates select="KTEXT"/>
                </name_bs_ID>
                <description_bs_ID>
                    <xsl:apply-templates select="LTEXT"/>
                </description_bs_ID>
            </xsl:when>
            <xsl:when test="SPRAS_ISO = 'PT'">               
                <name_pt_PT>
                    <xsl:apply-templates select="KTEXT"/>
                </name_pt_PT>
                <description_pt_PT>
                    <xsl:apply-templates select="LTEXT"/>
                </description_pt_PT>
            </xsl:when>
            <xsl:when test="SPRAS_ISO = 'PL'">               
                <name_pl_PL>
                    <xsl:apply-templates select="KTEXT"/>
                </name_pl_PL>
                <description_pl_PL>
                    <xsl:apply-templates select="LTEXT"/>
                </description_pl_PL>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Template for Status Derivation based on End Date --> 
    <xsl:template name="StatusDerivation">
        <xsl:param name="endDate"/>
        <xsl:param name="startDate"/>
        <xsl:param name="currentDate"/>
        <xsl:choose>
            <xsl:when test="($startDate &gt; $currentDate) and ($endDate &gt; $currentDate)">
                <xsl:value-of select="'InActive'"/>
            </xsl:when>
            <xsl:when test="(($startDate &lt; $currentDate) or ($startDate = $currentDate))and ($endDate &gt; $currentDate)">
                <xsl:value-of select="'Active'"/>
            </xsl:when>
            <xsl:when test="$endDate &lt; $currentDate">
                <xsl:value-of select="'InActive'"/>
            </xsl:when>
            <xsl:when test="$endDate = $currentDate">
                <xsl:value-of select="'InActive'"/>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Template for Date Converstion to "yyyy-MM-dd" --> 
    <xsl:template match="DATAB|DATBI">
        <xsl:value-of select="concat(substring(., 1, 4), &apos;-&apos;, substring(., 5, 2), &apos;-&apos;, substring(., 7, 2))"/>
    </xsl:template>
    
    
    <!-- Value Mapping for Company Code Conversion --> 
    <xsl:template name="ValueMapping">
        <xsl:param name="CompanyCode"/>
        <xsl:value-of select="ValueMap:executeMapping('OMS', 'COMP_CODE', $CompanyCode, '4S', 'COMP_CODE')"/>
    </xsl:template>
    
</xsl:stylesheet>
