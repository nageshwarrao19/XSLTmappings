<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>

    <!-- XSLT to Extract only Active Employees where Duplicate Value Exists -->

    <xsl:variable name="Grouping">
        <xsl:call-template name="root" />
    </xsl:variable>

    <xsl:template name ="root">
        <!-- grouping all same employees  -->
        <root>
            <xsl:for-each-group select="root/row" group-by="Employee_id">       
                <extract>
                <xsl:copy-of select="/root/row[Employee_id = current-grouping-key()]"/>               
               </extract>
            </xsl:for-each-group>
        </root>
        
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:call-template name="RemoveInactive">  
            <xsl:with-param name="Group" select="$Grouping"/>
        </xsl:call-template> 
    </xsl:template>
    
    
    <xsl:template name ="RemoveInactive">
        <xsl:param name="Group"/>
        <root>
            <xsl:for-each select="$Group/root/extract[count(row) > 1]">
                <xsl:copy-of select="row[Active ='Yes']"/>   
            </xsl:for-each>
            <xsl:for-each select="$Group/root/extract[count(row) = 1]">
                <xsl:copy-of select="row"/>   
            </xsl:for-each>
        </root>   
    </xsl:template>

</xsl:stylesheet>
