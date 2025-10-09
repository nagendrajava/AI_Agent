<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/address.xsl"/>
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/addressFirstPage.xsl"/>
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/headerNotes.xsl"/>
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/hyphenateSerial.xsl"/>
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/invoiceDetails.xsl"/>
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/invoiceDetailsFirstPage.xsl"/>
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/orderDetails.xsl"/>
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/orderDetailsHeader.xsl"/>
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/orderDetailsHeaderFirstPage.xsl"/>
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/footer.xsl"/>
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/blockWithBlank.xsl"/>
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/paymentNote.xsl"/>
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/shippingAndCharges.xsl"/>
    <xsl:include href="fop_template/us_equipment_sales_invoice/templateFiles/newLineForBlank.xsl"/>
    <xsl:param name="imageLocation"/>
    <xsl:param name="barcodeBase64"/>
    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"
            xmlns:functx="http://www.functx.com"
            xmlns:fox="http://xmlgraphics.apache.org/fop/extensions">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="contentOtherPages" page-width="210mm" page-height="297mm" margin-top="10mm" margin-bottom="8mm" margin-left="5mm" margin-right="5mm">
                    <fo:region-body margin-bottom="10mm" margin-top="54mm" border="1px solid black" />
                    <fo:region-before extent="5mm" region-name="other-page-header"/>
                    <fo:region-after extent="5mm" />
                </fo:simple-page-master>
                <fo:simple-page-master master-name="contentFirstPage" page-width="210mm" page-height="297mm" margin-top="10mm" margin-bottom="8mm" margin-left="5mm" margin-right="5mm">
                    <fo:region-body margin-bottom="17mm" margin-top="116mm" border="1px solid black" />
                    <fo:region-before extent="5mm" region-name="first-page-header"/>
                    <fo:region-after extent="5mm" />
                </fo:simple-page-master>
                <fo:page-sequence-master master-name="content">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference master-reference="contentFirstPage" page-position="first" />
                        <fo:conditional-page-master-reference master-reference="contentOtherPages" page-position="any" />
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="content">
                <!-- Static content for the header -->
                <fo:static-content flow-name="first-page-header">
                    <fo:block font-size="12pt" space-after.optimum="10pt">
                        <xsl:call-template name="orderDetailsHeaderFirstPage" />
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="other-page-header">
                    <fo:block font-size="12pt" space-after.optimum="10pt">
                        <xsl:call-template name="orderDetailsHeader" />
                    </fo:block>
                </fo:static-content>
                <!-- Static content for the footer -->
                <fo:static-content flow-name="xsl-region-after">
                    <xsl:call-template name="footer" />
                </fo:static-content>
                <!-- Flow content for the main body -->
                <fo:flow flow-name="xsl-region-body">
                    <fo:block>
                        <xsl:call-template name="orderDetails" />
                    </fo:block>
                    <fo:block id="last-page" />
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

</xsl:stylesheet>
