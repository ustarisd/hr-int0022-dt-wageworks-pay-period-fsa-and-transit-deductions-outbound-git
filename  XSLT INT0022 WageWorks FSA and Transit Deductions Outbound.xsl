<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:bc="urn:com.workday/bc"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xtt="urn:com.workday/xtt"
    xmlns:wd="urn:com.workday/INT0022"
    xmlns:etv="urn:com.workday/etv" xmlns:out="http://www.workday.com/integration/output"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:wdext="urn:com.workday/bsvc/integrations/extensions"
    version="2.0" exclude-result-prefixes="xsd xsl bc out">



    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Dec 3, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> Darren Ustaris</xd:p>
            <xd:p>INT0022 WageWorks FSA and Transit Deductions Outbound Document Transform XSLT</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xd:doc>
        <xd:desc>
            <xd:p> Set the output method to xml</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="xml" indent="yes"/>
    
    <xd:doc>
        <xd:desc>
            <xd:p>General Description of the template</xd:p>
        </xd:desc>
        <xd:param name="Param1">Detail Record</xd:param>
    </xd:doc>
    <xsl:template match="wd:Report_Data">
        
        <File xtt:required="true" xtt:severity="ERROR">
        
            
            <xsl:for-each select="wd:Report_Entry">
              
             
                <!--Dependent Care Record-->
              
                <xsl:if test="wd:CF_INT0022_ESI_FSA_Dependent_Care__Payroll_Result_ != ''">
                
                <Record_FSADC xtt:endTag="&#xA;" xtt:separator="|" >
                    
                   <RecordType xtt:fixedLength="3"><xsl:value-of select="wd:INT0022_CF_Record_Type_Text_Constant_FND"/></RecordType>
                   <GroupID xtt:fixedLength="20"><xsl:value-of select="wd:INT0022_CF_Group_ID_Text_Constant"/></GroupID>
                   <EmployeeID xtt:fixedLength="40"><xsl:value-of select="wd:Current_Worker/wd:Employee_ID"/></EmployeeID>
                   <UniqueID xtt:fixedLength="11"><xsl:value-of select="wd:Current_Worker/wd:Social_Security_Number"/></UniqueID>
                   <LastName xtt:fixedLength="40"><xsl:value-of select="wd:Current_Worker/wd:Legal_Name_-_Last_Name"/></LastName>
                   <FirstName xtt:fixedLength="40"><xsl:value-of select="wd:Current_Worker/wd:Legal_Name_-_First_Name"/></FirstName>
                    <PlanCode xtt:fixedLength="10" xtt:attribute="FSA Dependent Care Plan Code"></PlanCode>
                   
                   
                   <Sign xtt:fixedLength="1">
                       <xsl:choose>
                           <xsl:when test="wd:FSADC_Amount &gt; '0'">
                               <xsl:text></xsl:text>
                           </xsl:when>
                           <xsl:when test="wd:FSADC_Amount &lt;'0'">
                               <xsl:text>-</xsl:text>
                           </xsl:when>
                           <xsl:otherwise>
                               <xsl:text></xsl:text>
                           </xsl:otherwise>
                       </xsl:choose>
                   </Sign> 
                   
                   <Pre-TaxDeduction xtt:fixedLength="7" xtt:numberFormat="####.00">
                  
                       <xsl:value-of select="wd:FSADC_Amount"/>
                      
                      
                   </Pre-TaxDeduction>
                 
                   <Sign xtt:fixedLength="1">
                       <!--<xsl:choose>
                           <xsl:when test="wd:Pay_Component_Group_Result_-_Post_Tax_Deductions &gt; '0'">
                               <xsl:text></xsl:text>
                           </xsl:when>
                           <xsl:when test="wd:Pay_Component_Group_Result_-_Post_Tax_Deductions &lt;'0'">
                               <xsl:text>-</xsl:text>
                           </xsl:when>
                           <xsl:otherwise>
                               <xsl:text></xsl:text>
                           </xsl:otherwise>
                       </xsl:choose>-->
                   </Sign> 
                   
                   <Post-TaxDeduction xtt:fixedLength="7" xtt:numberFormat="####.00"><!--<xsl:value-of select="wd:Pay_Component_Group_Result_-_Post_Tax_Deductions"/>--></Post-TaxDeduction>
                   
                   
                   <OtherPostTaxContribution xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></OtherPostTaxContribution>
                   <Pre-TaxSponsorContributionElectAmount xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Pre-TaxSponsorContributionElectAmount>
                   <Pre-TaxSponsorContributionAddBenefit xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Pre-TaxSponsorContributionAddBenefit>
                   <Post-TaxSponsorContributionAddBenefit xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Post-TaxSponsorContributionAddBenefit>
                   
                   
                    <FundingDate xtt:fixedLength="12" xtt:dateFormat="YYYY/MM/dd"><xsl:value-of select="wd:CF_INT0022_DD_Payment_Date_-_2__Payroll_Result_"/></FundingDate>
                   
                   
                   
                   <Pre-TaxProgramSponsorInterest xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Pre-TaxProgramSponsorInterest>
                   <Post-TaxProgramSponsorInterest xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Post-TaxProgramSponsorInterest>
                   <BalanceTransferFromAccount xtt:fixedLength="15"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></BalanceTransferFromAccount>
                   <BalanceTransferPercentage xtt:fixedLength="3"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></BalanceTransferPercentage>
                   <BalanceTransferMaxAmount xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></BalanceTransferMaxAmount>
                   <CustomContributionDescription xtt:fixedLength="200"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></CustomContributionDescription>
                       
                   
                  
        
                </Record_FSADC>
                </xsl:if>
                
           
                <!--Healthcare Record-->
                
                <xsl:if test="wd:CF_INT0022_ESI_FSA_Health_Care__Payroll_Result_ != ''">
                    
                    <Record_FSAHC xtt:endTag="&#xA;" xtt:separator="|">
                        
                        <RecordType xtt:fixedLength="3"><xsl:value-of select="wd:INT0022_CF_Record_Type_Text_Constant_FND"/></RecordType>
                        <GroupID xtt:fixedLength="20"><xsl:value-of select="wd:INT0022_CF_Group_ID_Text_Constant"/></GroupID>
                        <EmployeeID xtt:fixedLength="40"><xsl:value-of select="wd:Current_Worker/wd:Employee_ID"/></EmployeeID>
                        <UniqueID xtt:fixedLength="11"><xsl:value-of select="wd:Current_Worker/wd:Social_Security_Number"/></UniqueID>
                        <LastName xtt:fixedLength="40"><xsl:value-of select="wd:Current_Worker/wd:Legal_Name_-_Last_Name"/></LastName>
                        <FirstName xtt:fixedLength="40"><xsl:value-of select="wd:Current_Worker/wd:Legal_Name_-_First_Name"/></FirstName>
                        <PlanCode xtt:fixedLength="10" xtt:attribute="FSA Health Care Plan Code"></PlanCode>
                       
                        
                        <Sign xtt:fixedLength="1">
                            <xsl:choose>
                                <xsl:when test="wd:FSAHC_Amount &gt; '0'">
                                    <xsl:text></xsl:text>
                                </xsl:when>
                                <xsl:when test="wd:FSAHC_Amount &lt;'0'">
                                    <xsl:text>-</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text></xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </Sign> 
                        
                        <Pre-TaxDeduction xtt:fixedLength="7" xtt:numberFormat="####.00">
                            
                            <xsl:value-of select="wd:FSAHC_Amount"/>
                            
                        </Pre-TaxDeduction>
                        
                        <Sign xtt:fixedLength="1">
                           <!-- <xsl:choose>
                                <xsl:when test="wd:Pay_Component_Group_Result_-_Post_Tax_Deductions &gt; '0'">
                                    <xsl:text></xsl:text>
                                </xsl:when>
                                <xsl:when test="wd:Pay_Component_Group_Result_-_Post_Tax_Deductions &lt;'0'">
                                    <xsl:text>-</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text></xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>-->
                        </Sign> 
                        
                        <Post-TaxDeduction xtt:fixedLength="7" xtt:numberFormat="####.00"><!--<xsl:value-of select="wd:Pay_Component_Group_Result_-_Post_Tax_Deductions"/>--></Post-TaxDeduction>
                        
                        
                        <OtherPostTaxContribution xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></OtherPostTaxContribution>
                        <Pre-TaxSponsorContributionElectAmount xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Pre-TaxSponsorContributionElectAmount>
                        <Pre-TaxSponsorContributionAddBenefit xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Pre-TaxSponsorContributionAddBenefit>
                        <Post-TaxSponsorContributionAddBenefit xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Post-TaxSponsorContributionAddBenefit>
                        
                        
                        <FundingDate xtt:fixedLength="12" xtt:dateFormat="YYYY/MM/dd"><xsl:value-of select="wd:CF_INT0022_DD_Payment_Date_-_2__Payroll_Result_"/></FundingDate>
                        
                        
                        
                        <Pre-TaxProgramSponsorInterest xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Pre-TaxProgramSponsorInterest>
                        <Post-TaxProgramSponsorInterest xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Post-TaxProgramSponsorInterest>
                        <BalanceTransferFromAccount xtt:fixedLength="15"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></BalanceTransferFromAccount>
                        <BalanceTransferPercentage xtt:fixedLength="3"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></BalanceTransferPercentage>
                        <BalanceTransferMaxAmount xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></BalanceTransferMaxAmount>
                        <CustomContributionDescription xtt:fixedLength="200"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></CustomContributionDescription>
                        
                        
                        
                        
                    </Record_FSAHC>
                </xsl:if>
                
                
                <!--HSA Record-->
                
                <xsl:if test="wd:CF_INT0022_ESI_HSA_Amount__Payroll_Result_ != ''">
                    
                    <Record_HSA xtt:endTag="&#xA;" xtt:separator="|">
                        
                        <RecordType xtt:fixedLength="3"><xsl:value-of select="wd:INT0022_CF_Record_Type_Text_Constant_FND"/></RecordType>
                        <GroupID xtt:fixedLength="20"><xsl:value-of select="wd:INT0022_CF_Group_ID_Text_Constant"/></GroupID>
                        <EmployeeID xtt:fixedLength="40"><xsl:value-of select="wd:Current_Worker/wd:Employee_ID"/></EmployeeID>
                        <UniqueID xtt:fixedLength="11"><xsl:value-of select="wd:Current_Worker/wd:Social_Security_Number"/></UniqueID>
                        <LastName xtt:fixedLength="40"><xsl:value-of select="wd:Current_Worker/wd:Legal_Name_-_Last_Name"/></LastName>
                        <FirstName xtt:fixedLength="40"><xsl:value-of select="wd:Current_Worker/wd:Legal_Name_-_First_Name"/></FirstName>
                        <PlanCode xtt:fixedLength="10" xtt:attribute="HSA Plan Code"></PlanCode>
                        
                        
                        <Sign xtt:fixedLength="1">
                            <xsl:choose>
                                <xsl:when test="wd:FSAHC_Amount &gt; '0'">
                                    <xsl:text></xsl:text>
                                </xsl:when>
                                <xsl:when test="wd:FSAHC_Amount &lt;'0'">
                                    <xsl:text>-</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text></xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </Sign> 
                        
                        <Pre-TaxDeduction xtt:fixedLength="7" xtt:numberFormat="####.00">
                            
                            <xsl:value-of select="wd:CF_INT0022_LRV_HSA_Amount__Payroll_Result_"/>
                            
                        </Pre-TaxDeduction>
                        
                        <Sign xtt:fixedLength="1">
                            <!-- <xsl:choose>
                                <xsl:when test="wd:Pay_Component_Group_Result_-_Post_Tax_Deductions &gt; '0'">
                                    <xsl:text></xsl:text>
                                </xsl:when>
                                <xsl:when test="wd:Pay_Component_Group_Result_-_Post_Tax_Deductions &lt;'0'">
                                    <xsl:text>-</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text></xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>-->
                        </Sign> 
                        
                        <Post-TaxDeduction xtt:fixedLength="7" xtt:numberFormat="####.00"><!--<xsl:value-of select="wd:Pay_Component_Group_Result_-_Post_Tax_Deductions"/>--></Post-TaxDeduction>
                        
                        
                        <OtherPostTaxContribution xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></OtherPostTaxContribution>
                        <Pre-TaxSponsorContributionElectAmount xtt:fixedLength="8"><xsl:value-of select="wd:Pay_Component_Group_Result_-_Pre_Tax_Deductions"/></Pre-TaxSponsorContributionElectAmount>
                        <Pre-TaxSponsorContributionAddBenefit xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Pre-TaxSponsorContributionAddBenefit>
                        <Post-TaxSponsorContributionAddBenefit xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Post-TaxSponsorContributionAddBenefit>
                        
                        
                        <FundingDate xtt:fixedLength="12" xtt:dateFormat="YYYY/MM/dd"><xsl:value-of select="wd:CF_INT0022_DD_Payment_Date_-_2__Payroll_Result_"/></FundingDate>
                        
                        
                        
                        <Pre-TaxProgramSponsorInterest xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Pre-TaxProgramSponsorInterest>
                        <Post-TaxProgramSponsorInterest xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></Post-TaxProgramSponsorInterest>
                        <BalanceTransferFromAccount xtt:fixedLength="15"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></BalanceTransferFromAccount>
                        <BalanceTransferPercentage xtt:fixedLength="3"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></BalanceTransferPercentage>
                        <BalanceTransferMaxAmount xtt:fixedLength="8"><!--<xsl:value-of select="wd:PAY_NUMBER"/>--></BalanceTransferMaxAmount>
                        <CustomContributionDescription xtt:fixedLength="200" xtt:attribute="HSA Contribution Description"></CustomContributionDescription>
                        
                        
                        
                        
                    </Record_HSA>
                </xsl:if>
                
                
                
                
            </xsl:for-each>
            <wdext:Integration_Messages
                xmlns:wdext="urn:com.workday/bsvc/integrations/extensions">
                <wdext:Integration_Message>
                    <wdext:Severity>ERROR:</wdext:Severity>
                    <wdext:Summary> Worker(s) do not have FSADC, FSAHC, or HSA deductions populated currently.</wdext:Summary>
                </wdext:Integration_Message>
            </wdext:Integration_Messages>

        </File>
    </xsl:template>

    
</xsl:stylesheet>