<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="invoiceDetails">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:block font-size="14pt" font-family="Verdana" font-weight="bold" text-align="center">
                <fo:inline color = "#EE4B2B">REVISED </fo:inline>
                <fo:inline>RENTAL INVOICE</fo:inline>
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
                    <fo:table-row font-size="9pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="left">
                            <fo:block>Customer #:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="left">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/Customer/CustNo" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row font-size="9pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="left">
                            <fo:block>Invoice Date:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="left">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/InvoiceDate" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row font-size="9pt" border="1pt solid black">
                        <fo:table-cell border="1pt solid black" font-weight="bold" text-align="left">
                            <fo:block>Invoice Amount:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="1pt solid black" text-align="left">
                            <fo:block>
                                <xsl:value-of select="Invoice/Header/RentedInfo/InvoiceAmount" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row font-size="9pt" border="1pt solid black">
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

        </fo:block>
    </xsl:template>
</xsl:stylesheet>