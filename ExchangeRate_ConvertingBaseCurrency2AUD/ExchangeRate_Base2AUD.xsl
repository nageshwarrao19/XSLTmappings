<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:exch="http://orica.com/exchange_rates"
    exclude-result-prefixes="xs exch"
    version="2.0">
    
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    
    <xsl:variable name="AUD2USDfactor"> 
        <xsl:apply-templates select="//exch:ExchangeRate[exch:FromCurrency ='USD'][exch:ToCurrency ='AUD']" mode="extractAUD2USDfactor"/> 
    </xsl:variable>
    
    <xsl:template match="/">     
        <exch:ExchangeRatesIntermediateMessage>
            <exch:ExchangeRates>
                <xsl:apply-templates/>
            </exch:ExchangeRates>
        </exch:ExchangeRatesIntermediateMessage>
    </xsl:template>
     
    <xsl:template match="exch:ExchangeRate[exch:ToCurrency !='AUD']">    
        <exch:ExchangeRate>
            <exch:FromCurrency>AUD</exch:FromCurrency>
            <exch:ToCurrency><xsl:value-of select="exch:ToCurrency"/></exch:ToCurrency>
            <exch:UpdateDate><xsl:value-of select="exch:UpdateDate"/></exch:UpdateDate>
            <exch:Rate>
                <xsl:value-of select="format-number((number($AUD2USDfactor)*exch:Rate),'0.00000')"/>  
            </exch:Rate> 
        </exch:ExchangeRate>
    </xsl:template> 
    
    <xsl:template match="exch:ExchangeRate[exch:FromCurrency ='USD'][exch:ToCurrency ='AUD']">    
        <exch:ExchangeRate>
            <exch:FromCurrency>AUD</exch:FromCurrency>
            <exch:ToCurrency>USD</exch:ToCurrency>
            <exch:UpdateDate><xsl:value-of select="exch:UpdateDate"/></exch:UpdateDate>
            <exch:Rate>
                <xsl:value-of select="$AUD2USDfactor"/>  
            </exch:Rate> 
        </exch:ExchangeRate>
    </xsl:template> 
    
    <xsl:template match="exch:ExchangeRate" mode="extractAUD2USDfactor">     
        <xsl:value-of select="format-number((number(1) div number (exch:Rate)),'0.00000')"/>  
    </xsl:template> 
    
    
    <!-- Default template to do nothing -->
    <xsl:template match="text()" priority="-100"/>
    
    
</xsl:stylesheet>