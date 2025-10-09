<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="invoiceDetailsFirstPage">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:block font-size="14pt" font-family="Verdana" font-weight="bold" text-align="center">
                <xsl:value-of select="Invoice/Header/InvoiceType" />
            </fo:block>
            <!-- <fo:block text-align="center">
                <xsl:variable name="imagePath">
                    <xsl:value-of select="concat($imageLocation, '/', Invoice/Header/RentedInfo/InvoiceNo, '.png')"/>
                </xsl:variable>
                <fo:external-graphic content-width="60%" content-height="60%" src="url({$imagePath})"/>
            </fo:block> -->
            <fo:block text-align="center">
                <fo:external-graphic content-width="60%" content-height="60%" src="{$barcodeBase64}"/>
            </fo:block>
            <fo:block text-align="center">
                <xsl:value-of select="Invoice/Header/RentedInfo/InvoiceNo" />
            </fo:block>
            <fo:table border="1pt solid black">
                <fo:table-column column-width="50%" />
                <fo:table-column column-width="50%" />
                <fo:table-body>
                    <fo:table-row font-size="10pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="left">
                            <fo:block>Customer #:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="left">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/Customer/CustNo" />
                            </fo:block>
                        </fo:table-cell>

                    </fo:table-row>
                    <fo:table-row font-size="10pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="left">
                            <fo:block>Invoice Date:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="left">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/InvoiceDate" />
                            </fo:block>
                        </fo:table-cell>

                    </fo:table-row>
                    <fo:table-row font-size="10pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="left">
                            <fo:block>Invoice Amount:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="left">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/InvoiceAmount" />
                            </fo:block>
                        </fo:table-cell>

                    </fo:table-row>
                    <fo:table-row font-size="10pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="left">
                            <fo:block>Payment Terms:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="left">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/Terms" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
            <fo:table border="1pt solid black">
                <fo:table-column column-width="100%" />

                <fo:table-body>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="center" background-color="#c8c4c4">
                            <fo:block>ACH PAYMENT</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
            <fo:table border="1pt solid black">
                <fo:table-column column-width="50%" />
                <fo:table-column column-width="50%" />

                <fo:table-body>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border-left="1pt solid black" font-weight="bold" text-align="left">
                            <fo:block>Beneficiary's Bank:</fo:block>
                            <fo:block>RTN/ABA#:</fo:block>
                            <fo:block>Acct#:</fo:block>
                            <fo:block>Beneficiary's Name:</fo:block>
                            <fo:block>Remittance Advice:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border-right="1pt solid black" text-align="left">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/ACHPayment/BeneficiarysBank" />
                            </fo:block>
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/ACHPayment/RTNABA" />
                            </fo:block>
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/ACHPayment/AcctNo" />
                            </fo:block>
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/ACHPayment/BeneficiarysName" />
                            </fo:block>
                            <fo:block color="blue">
                                <xsl:value-of select="Invoice/Header/RentedInfo/ACHPayment/RemittanceAdvice" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>

                </fo:table-body>
            </fo:table>
            <fo:table border="1pt solid black">
                <fo:table-column column-width="100%" />

                <fo:table-body>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="center" background-color="#c8c4c4">
                            <fo:block>CHECK PAYMENT</fo:block>
                        </fo:table-cell>

                    </fo:table-row>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" text-align="center">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/CheckPayment/CompanyName" />
                                <xsl:value-of select="Invoice/Header/RentedInfo/CheckPayment/Address/Line1" />
                                <xsl:value-of select="concat(Invoice/Header/RentedInfo/CheckPayment/Address/City,',',Invoice/Header/RentedInfo/CheckPayment/Address/State ,' ',Invoice/Header/RentedInfo/CheckPayment/Address/ZipCode)" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>

                </fo:table-body>
            </fo:table>
            <fo:table border="1pt solid black">
                <fo:table-column column-width="100%" />

                <fo:table-body>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="center" background-color="#c8c4c4">
                            <fo:block>Pay By Phone/Questions: 
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" text-align="center">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/PaybyPhone/Phone" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="center" background-color="#c8c4c4">
                            <fo:block>Pay Online with ProControl NextGen : 
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" text-align="center">
                            <fo:block>
                                <fo:inline color="blue">
                                    <xsl:value-of select="Invoice/Header/RentedInfo/OnlinePayment/Website" />
                                </fo:inline>

                                <xsl:value-of select="Invoice/Header/RentedInfo/OnlinePayment/Info" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
            <fo:table border="1pt solid black">
                <fo:table-column column-width="50%" />
                <fo:table-column column-width="50%" />
                <fo:table-body>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="left">
                            <fo:block>AMOUNT ENCLOSED: $
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="left">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/AmountEnclosed" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>

        </fo:block>
    </xsl:template>
</xsl:stylesheet>