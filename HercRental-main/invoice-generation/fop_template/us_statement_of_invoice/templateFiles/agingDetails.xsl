<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="agingDetails">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:block-container width="119%" margin-right="-21%">
                <fo:block margin-right="12%">
                    <fo:table table-layout="fixed" width="108%">
                        <fo:table-column column-width="12%" />
                        <fo:table-column column-width="11%" />
                        <fo:table-column column-width="11%" />
                        <fo:table-column column-width="11%" />
                        <fo:table-column column-width="11%" />
                        <fo:table-column column-width="11%" />
                        <fo:table-column column-width="11%" />
                        <fo:table-column column-width="22%" />
                        <fo:table-body start-indent="0pt">

                            <fo:table-row font-size="10pt" border-top="2pt solid black" font-weight="bold">
                                <fo:table-cell column-number="1" text-align="center" margin-right="1%" border-right="1pt solid black">
                                    <fo:block >
                                        <!-- Aging Summary -->
                                        Aging Summary
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="2" text-align="center" margin-right="1%" border-bottom="1pt solid black" border-right="1pt solid black">
                                    <fo:block >
                                        0-30
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="3" text-align="center" margin-right="1%" border-bottom="1pt solid black" border-right="1pt solid black">
                                    <fo:block >
                                        31-60
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="4" text-align="center" margin-right="1%" border-bottom="1pt solid black" border-right="1pt solid black">
                                    <fo:block >
                                        61-90
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="5" text-align="center" margin-right="1%" border-bottom="1pt solid black" border-right="1pt solid black">
                                    <fo:block >
                                        91-120
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="6" text-align="center" margin-right="1%" border-bottom="1pt solid black" border-right="1pt solid black">
                                    <fo:block >
                                        121+
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="7" text-align="center" margin-right="1%" border-bottom="1pt solid black" border-right="1pt solid black">
                                    <fo:block >
                                        Total Due [US]
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="8" text-align="center" margin-right="1%" border-bottom="1pt solid black" border-right="1pt solid black">
                                    <fo:block >
                                        Total Due [US]
                                    </fo:block >
                                </fo:table-cell >

                            </fo:table-row>
                            <fo:table-row font-size="8pt" border-bottom="2pt solid black">
                                <fo:table-cell column-number="1" text-align="left" border-right="1pt solid black">
                                    <fo:block >

                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="2" text-align="right" margin-right="1%" border-right="1pt solid black">
                                    <fo:block >
                                        <xsl:value-of select="Invoice/Detail/AgingSummary/Days30" />
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="3" text-align="right" margin-right="1%" border-right="1pt solid black">
                                    <fo:block >
                                        <xsl:value-of select="Invoice/Detail/AgingSummary/Days60" />
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="4" text-align="right" margin-right="1%" border-right="1pt solid black">
                                    <fo:block >
                                        <xsl:value-of select="Invoice/Detail/AgingSummary/Days90" />
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="5" text-align="right" margin-right="1%" border-right="1pt solid black">
                                    <fo:block >
                                        <xsl:value-of select="Invoice/Detail/AgingSummary/Days120" />
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="6" text-align="right" margin-right="1%" border-right="1pt solid black">
                                    <fo:block >
                                        <xsl:value-of select="Invoice/Detail/AgingSummary/Days121" />
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="7" text-align="right" margin-right="1%" border-right="1pt solid black">
                                    <fo:block >
                                        <xsl:value-of select="Invoice/Detail/AgingSummary/TotalDues" />
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="8" text-align="right" margin-right="1%" border-right="1pt solid black">
                                    <fo:block >
                                        <xsl:value-of select="Invoice/Detail/AgingSummary/TotalDues" />
                                    </fo:block >
                                </fo:table-cell >

                            </fo:table-row>
                            <fo:table-row font-size="10pt" font-weight="bold">
                                <fo:table-cell column-number="1" number-columns-spanned="4" text-align="left" margin-right="1%">
                                    <fo:block >
                                        <xsl:value-of select="'&#x2028;'" />
                                        <xsl:value-of select="Invoice/Detail/AgingSummary/AgingNotes" />
                                        <xsl:value-of select="'&#x2028;'" />
                                        <xsl:value-of select="'&#x2028;'" />
                                    </fo:block >
                                </fo:table-cell >
                            </fo:table-row>
                            <fo:table-row font-size="10pt" font-weight="bold">
                                <fo:table-cell column-number="1" border="2pt solid black" number-columns-spanned="3" text-align="left" margin-right="1%">
                                    <fo:block >
                                        <xsl:value-of select="Invoice/Detail/AgingSummary/DirectInquiries/Header" />
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="4" number-columns-spanned="4" border="2pt solid black" text-align="center" margin-right="1%">
                                    <fo:block>ACH PAYMENT</fo:block>
                                </fo:table-cell >
                                <fo:table-cell column-number="8" text-align="center" margin-right="1%" border-top="2pt solid black" border-left="2pt solid black" border-bottom="1pt solid black">
                                    <fo:block>TOTAL PAID</fo:block>
                                </fo:table-cell >
                            </fo:table-row>
                            <fo:table-row font-size="8pt">
                                <fo:table-cell column-number="1" border="2pt solid black" number-columns-spanned="3" text-align="left" margin-right="1%">
                                    <fo:block >
                                        <xsl:value-of select="Invoice/Detail/AgingSummary/DirectInquiries/Name" />
                                        <xsl:value-of select="'&#x2028;'" />
                                        Phone: 
                                        <xsl:value-of select="Invoice/Detail/AgingSummary/DirectInquiries/Phone" />
                                        <xsl:value-of select="'&#x2028;'" />
                                        Email: 
                                        <xsl:value-of select="Invoice/Detail/AgingSummary/DirectInquiries/Email" />
                                        <xsl:value-of select="'&#x2028;'" />
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="4" number-columns-spanned="4" border="2pt solid black" text-align="left" margin-right="1%">
                                    <fo:block >
                                        <fo:inline font-weight="bold">Beneficiary's Bank:</fo:inline>
                                        <xsl:value-of select="Invoice/Header/RentedInfo/ACHPayment/BeneficiarysBank" />
                                        <xsl:value-of select="'&#x2028;'" />
                                        <fo:inline font-weight="bold">RTN/ABA#:</fo:inline>
                                        <xsl:value-of select="Invoice/Header/RentedInfo/ACHPayment/RTNABA" />
                                        <xsl:value-of select="'&#x2028;'" />
                                        <fo:inline font-weight="bold">Acct#:</fo:inline>
                                        <xsl:value-of select="Invoice/Header/RentedInfo/ACHPayment/AcctNo" />
                                        <xsl:value-of select="'&#x2028;'" />
                                        <fo:inline font-weight="bold">Beneficiary's Name:</fo:inline>
                                        <xsl:value-of select="Invoice/Header/RentedInfo/ACHPayment/BeneficiarysName" />
                                        <xsl:value-of select="'&#x2028;'" />
                                    </fo:block >
                                </fo:table-cell >
                                <fo:table-cell column-number="8" text-align="center" margin-right="1%" border-top="1pt solid black" border-left="2pt solid black" border-bottom="2pt solid black">

                                </fo:table-cell >
                            </fo:table-row>

                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </fo:block-container>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>