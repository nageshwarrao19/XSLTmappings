<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n0="http://sap.com/xi/SAPGlobal20/Global">
	<xsl:output method="text" encoding="utf-8" />
	
	<xsl:param name="delim" select="','" />
	<xsl:param name="quote" select="'&quot;'" />
	<xsl:param name="break" select="'&#xA;'" />
	
	<xsl:template match="n0:IdentityBusinessRoleQueryByElementsResponseMessageType">
		<xsl:value-of select="concat($quote,'RoleID',$quote,$delim,$quote,'RoleName',$quote)"/>
		<xsl:value-of select="$break" />
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="BusinessRole">
		<xsl:value-of select="concat($quote, ./ID, $quote, $delim, $quote, ./Name, $quote, $break)"/>	
	</xsl:template>
	
	<xsl:template match="text()" />
	
</xsl:stylesheet>
