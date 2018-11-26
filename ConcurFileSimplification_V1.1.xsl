<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:ns1="urn:orica-com:po:FIN:CONCUR" xmlns:ns0="http://sap.com/xi/XI/SplitAndMerge"
    xmlns:ValueMap="com.sap.aii.mapping.value.api.XIVMService">
    <xsl:strip-space elements="*"/>
    <xsl:output method="xml" indent="yes"/>
    <!-- XSLT Mapping to ignore all the unwanted Fields from Source file. Source file contains more thn 400 fields
    Also Filters are applied based on Payment Conditions    
    -->

    <xsl:template match="Recordset">
        <ns0:Messages>
            <ns0:Message1>
                <ns1:ConcurSAE>
                    <Recordset>
                        <xsl:apply-templates select="Items"/>
                    </Recordset>
                </ns1:ConcurSAE>
            </ns0:Message1>
        </ns0:Messages>
    </xsl:template>

    <xsl:template match="Items">
        <xsl:variable name="reportID">
            <xsl:value-of select="CT_REPORT_REPORT_ID"/>
        </xsl:variable>
        <xsl:variable name="paymentTaxType">
            <xsl:value-of select="CT_PAYMENT_TYPE_LANG_NAME_1"/>
        </xsl:variable>
        <xsl:variable name="paymentCardType">
            <xsl:value-of select="CT_PAYMENT_TYPE_LANG_NAME"/>
        </xsl:variable>
        <xsl:variable name="concurExpenseType">
            <xsl:value-of select="CT_EXPENSE_TYPE_LANG_NAME"/>
        </xsl:variable>    
        
        <xsl:variable name="concurOrgUnit">
            <xsl:value-of select="CT_EMPLOYEE_ORG_UNIT1"/>
        </xsl:variable> 
        
        
        <!-- Checking if the Concur Provided Org Unit (Company Code) needs to be passed to SF or not.
             This is maintained by Value Mapping Table in ID which returns value INCLUDE
		-->
        <xsl:variable name="includeOrgUnit">
            <xsl:call-template name="ValueMapping">
                <xsl:with-param name="SenderParam" select="$concurOrgUnit"/>
                <xsl:with-param name="Scheme" select="'PAYROLLCOMPCODE'"/>
            </xsl:call-template>
        </xsl:variable>
        
        <!-- Ignoring all the line items where Report ID is null i.e Cash Advance Transaction type = '1'
			or the Payment Type is among ‘VATVAT or CAGST or PSTSK or PSTMB or PSTBC or HSTNB or CAQST or HSTNS or HSTNL or HSTON or HSTPE or RTCON or RTCPE’
			or the Payment is via ‘COMPANY CREDIT CARD or COMPANY PCARD’	
			or the Org Unit provided by Concur is to be excluded ( i.e to be included)  - This is maintained by Value Mapping Table in ID
		-->

        <xsl:if
            test="
            (($reportID != '') and ($includeOrgUnit = 'INCLUDE') and (not(contains(concat('/VAT/', '/CAGST/', '/PSTSK/', '/PSTMB/', '/PSTBC/', '/HSTNB/', '/CAQST/', '/HSTNS/', '/HSTNL/', '/HSTON/', '/HSTPE/', '/RTCON/', '/RTCPE/'), $paymentTaxType)))
                and (not(contains(concat('/COMPANY CREDIT CARD/', '/COMPANY PCARD/'), $paymentCardType))))">

            <Items>
                <CT_REPORT_REPORT_ID>
                    <xsl:value-of select="CT_REPORT_REPORT_ID"/>
                </CT_REPORT_REPORT_ID>
                <CT_REPORT_RPT_KEY>
                    <xsl:value-of select="CT_REPORT_RPT_KEY"/>
                </CT_REPORT_RPT_KEY>
                <CT_EMPLOYEE_EMP_ID>
                    <xsl:value-of select="CT_EMPLOYEE_EMP_ID"/>
                </CT_EMPLOYEE_EMP_ID>
                <CT_EMPLOYEE_ORG_UNIT1>
                    <xsl:value-of select="CT_EMPLOYEE_ORG_UNIT1"/>
                </CT_EMPLOYEE_ORG_UNIT1>

                <!-- Converting the Concur Expense Type to SF Wage Type Code based on Value Mapping Table Maintained in ID
                    If value mapping doesn't return any value, Default Wage Type - 'GL-6503' is set 
                -->

                <xsl:variable name="ExpenseType">
                    <xsl:call-template name="ValueMapping">
                        <xsl:with-param name="SenderParam" select="$concurExpenseType"/>
                        <xsl:with-param name="Scheme" select="'WAGETYPE'"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$ExpenseType = ''">
                        <CT_EXPENSE_TYPE_LANG_NAME>
                            <xsl:value-of select="'GL-6503'"/>
                        </CT_EXPENSE_TYPE_LANG_NAME>
                    </xsl:when>
                    <xsl:otherwise>
                        <CT_EXPENSE_TYPE_LANG_NAME>
                            <xsl:value-of select="$ExpenseType"/>
                        </CT_EXPENSE_TYPE_LANG_NAME>
                    </xsl:otherwise>
                </xsl:choose>


                <BATCHDATE>
                    <xsl:value-of select="BATCHDATE"/>
                </BATCHDATE>
                <CT_CURRENCY_ALPHA_CODE>
                    <xsl:value-of select="CT_CURRENCY_ALPHA_CODE"/>
                </CT_CURRENCY_ALPHA_CODE>
                <CT_JOURNAL_AMOUNT>
                    <xsl:value-of select="CT_JOURNAL_AMOUNT"/>
                </CT_JOURNAL_AMOUNT>
                <CT_JOURNAL_DEBIT_OR_CREDIT>
                    <xsl:value-of select="CT_JOURNAL_DEBIT_OR_CREDIT"/>
                </CT_JOURNAL_DEBIT_OR_CREDIT>
            </Items>
        </xsl:if>
    </xsl:template>

    <!-- Value mapping Template to Convert Concur Specific Values to SuccessFactors Specific Values
        Sender Agency and Target Agency is Fixed and Scheme and Parameters are passed    
    -->
    <xsl:template name="ValueMapping">
        <xsl:param name="SenderParam"/>
        <xsl:param name="Scheme"/>
        <xsl:value-of
            select="ValueMap:executeMapping('CONCUR', $Scheme, $SenderParam, 'SUCCESSFACTORS', $Scheme)"
        />
    </xsl:template>


</xsl:stylesheet>
