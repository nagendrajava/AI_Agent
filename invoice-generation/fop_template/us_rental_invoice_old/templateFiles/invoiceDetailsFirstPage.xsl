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
                    <fo:table-row font-size="8pt" background-color="#c8c4c4" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="center">
                            <fo:block>INVOICE NO.</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="center">
                            <fo:block>INVOICE DATE</fo:block>
                        </fo:table-cell>

                    </fo:table-row>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" text-align="center" padding="2%">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/InvoiceNo" />
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="center" padding="2%">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/InvoiceDate" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row font-size="8pt" background-color="#c8c4c4" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="center">
                            <fo:block>INVOICE AMOUNT</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="center">
                            <fo:block>CURRENCY</fo:block>
                        </fo:table-cell>

                    </fo:table-row>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" padding="2%">
                            <fo:table width="100%">
                                <fo:table-column column-width="10%" />
                                <fo:table-column column-width="90%" />
                                <fo:table-body>
                                    <fo:table-row text-align="center">
                                        <fo:table-cell>
                                            <fo:block>$</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of
                                                    select="Invoice/Header/RentedInfo/InvoiceAmount" />
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="center" padding="2%">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/Currency" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row font-size="8pt" background-color="#c8c4c4" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="center">
                            <fo:block>CUSTOMER NO.</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="center">
                            <fo:block>TERMS</fo:block>
                        </fo:table-cell>

                    </fo:table-row>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" text-align="center" padding="2%">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/Customer/CustNo" />
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="center" padding="2%">
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
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="center">
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
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="left">
                            <fo:block>Beneficiary's Bank:</fo:block>
                            <fo:block>RTN/ABA#:</fo:block>
                            <fo:block>Acct#:</fo:block>
                            <fo:block>Beneficiary's Name:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="left">
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
                            <fo:block>CHECK PAYMENT</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="left">
                            <fo:block>ONLINE PAYMENT</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" text-align="left">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/CheckPayment/CompanyName" />
                            </fo:block>
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/CheckPayment/Address/Line1" />
                            </fo:block>
                            <fo:block>
                                <xsl:value-of select="concat(Invoice/Header/RentedInfo/CheckPayment/Address/City,',',Invoice/Header/RentedInfo/CheckPayment/Address/State ,' ',Invoice/Header/RentedInfo/CheckPayment/Address/ZipCode)" />
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="left" color="blue">
                            <fo:block>
                                <fo:external-graphic content-width="20%">
                                    <xsl:attribute name="src">
                                        <xsl:value-of select="Invoice/Header/RentedInfo/OnlinePayment/Logo" />
                                    </xsl:attribute>
                                </fo:external-graphic>
                            </fo:block>
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/OnlinePayment/Website" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>

                </fo:table-body>
            </fo:table>
            <fo:table border="1pt solid black">
                <fo:table-column column-width="100%" />

                <fo:table-body>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="center">
                            <fo:block>PAY BY PHONE/QUESTIONS: <xsl:value-of select="Invoice/Header/RentedInfo/PaybyPhone/Phone" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
            <fo:table border="1pt solid black">
                <fo:table-column column-width="100%" />

                <fo:table-body>
                    <fo:table-row font-size="8pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="left">
                            <fo:block>AMOUNT ENCLOSED: <xsl:value-of select="Invoice/Header/RentedInfo/AmountEnclosed" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>