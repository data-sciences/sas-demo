<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" 
  xmlns:odm="http://www.cdisc.org/ns/odm/v1.2"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3c.org/2001/XMLSchema-instance"
  xmlns:def="http://www.cdisc.org/ns/def/v1.0"
  xmlns:xlink="http://www.w3c.org/1999/xlink">
<xsl:output method="html" version="4.0" encoding="ISO-8859-1" indent="yes"/>
<!-- ****************************************************************************************************** -->
<!-- File: define1-0-0.xsl                                                                                  -->
<!-- Date: 28-01-2005                                                                                       -->
<!-- Version: 1.0.0                                                                                         -->
<!-- Author: William Qubeck (Pfizer), William Friggle (Sanofi-Synthelabo), Anthony Friebel (SAS)            -->
<!-- Organization: Clinical Data Interchange Standards Consortium (CDISC)                                   -->
<!-- Description: This is a Style Sheet for the Case Report Tabulation Data Definition Specification        -->
<!--   Version 1.0.0.  This document is compliant with XSLT Version 1.0 specification (1999).               -->
<!-- Notes:  The define.xml document can be rendered in a format that is human readable if it contains an   -->
<!--   explicit XML style sheet reference.  The style sheet reference should be placed immediately before   -->
<!--   the ODM root element.  If the define.xml includes the XSLT reference and the corresponding style     -->
<!--   sheet is available in the same folder as the define.xml file, a browser application will format the  -->
<!--   output to mirror the data definition document layout as described within the define.xml              -->
<!--   specification.                                                                                       -->
<!-- Source Location:  http://www.cdisc.org/models/def/v1.0/define1-0-0.xsl                                 -->
<!-- Release Notes for version 1.0.0:                                                                       -->
<!--   1. It is a default initial version of the define.xml style sheet.                                    -->
<!--   2. The order presentation of both the TOC and Data Definition Tables Sections are based on the       -->
<!--      sequence of the items in the define.xml, a future release may order components based on their     -->
<!--      ItemRef@OrderNumber values                                                                        -->
<!--   3. The resulting HTML presentation and the availability/usability of functions WILL vary depending   -->
<!--      upon which application used.  Some browsers currently do not either correctly implement XSLT      -->
<!--      Version 1.0 or HTML Version 4.0 specifications.                                                   -->
<!--   4. Hypertext linking to the Case Report Form (CRF) is by default provided as footnote to each table  -->
<!--      if there is at least one def:AnnotatedCRF/def:DocumentRef                                         --> 
<!--   5. Hypertext linking to the Supplemental Data Definition Material is by default provided as footnote -->
<!--      to each table if there is at least one def:SupplementalDoc/def:DocumentRef                        -->
<!--   6. A future release will expand the amount of hypertext linking external documents (e.g., CRF)       -->
<!-- ****************************************************************************************************** -->

<!-- **************************************************** -->
<!-- Create the HTML Header                               -->
<!-- **************************************************** -->
<xsl:template match="/">
  <html>
   <head>
    <title>Study <xsl:value-of select="/odm:ODM/odm:Study/odm:GlobalVariables/odm:StudyName"/>, Data Definitions</title>
   </head>
   <body>
      <xsl:apply-templates/>
   </body>
  </html>
</xsl:template>

<!-- ********************************************************* -->
<!-- Create the Table Of Contents, define.xml specification    -->
<!--  Section 2.1.1.                                           -->
<!-- ********************************************************* -->
<xsl:template match="/odm:ODM/odm:Study/odm:GlobalVariables"/>
<xsl:template match="/odm:ODM/odm:Study/odm:MetaDataVersion">
  <a name='TOP'/>		
  <table  border='2' cellspacing='0' cellpadding='4'>
    <tr>
      <th colspan='6' align='left' valign='top' height='20'>Datasets for Study <xsl:value-of select="/odm:ODM/odm:Study/odm:GlobalVariables/odm:StudyName"/></th>
    </tr>
    <font face='Times New Roman' size='3'/>
    <tr align='center'>
      <th align='center' valign='bottom'>Dataset</th> 
      <th align='center' valign='bottom'>Description</th> 
      <th align='center' valign='bottom'>Structure</th>
      <th align='center' valign='bottom'>Purpose</th>
      <th align='center' valign='bottom'>Keys</th>
      <th align='center' valign='bottom'>Location</th>
    </tr>	
    <xsl:for-each select="./odm:ItemGroupDef">
       <xsl:call-template name="ItemGroupDef"/>
    </xsl:for-each>		
  </table>
  <xsl:call-template name="AnnotatedCRF"/> 
  <xsl:call-template name="SupplementalDataDefinitionDoc"/>
  <xsl:call-template name="linktop"/>
  <xsl:call-template name="DocGenerationDate"/> 

  <!-- **************************************************** -->
  <!-- Create the Data Definition Tables, define.xml        -->
  <!--  specificaiton Section 2.1.2.                        -->
  <!-- **************************************************** -->
  <xsl:for-each select="./odm:ItemGroupDef">	
    <xsl:call-template name="ItemRef"/>
    <xsl:call-template name="AnnotatedCRF"/>
    <xsl:call-template name="SupplementalDataDefinitionDoc"/>
    <xsl:call-template name="linktop"/>
    <xsl:call-template name="DocGenerationDate"/>  
  </xsl:for-each>

  <!-- ****************************************************  -->
  <!-- Create the Value Level Metadata (Value List), define  -->
  <!--  XML specification Section 2.1.4.                     -->
  <!-- ****************************************************  -->
  <xsl:call-template name="AppendixValueList"/>
  <xsl:call-template name="AnnotatedCRF"/> 
  <xsl:call-template name="SupplementalDataDefinitionDoc"/>
  <xsl:call-template name="linktop"/>
  <xsl:call-template name="DocGenerationDate"/> 

  <!-- ****************************************************  -->
  <!-- Create the Computational Algorithms, define.xml       -->
  <!--  specification Section 2.1.5.                         -->
  <!-- ****************************************************  -->
  <xsl:call-template name="AppendixComputationMethod"/>
  <xsl:call-template name="AnnotatedCRF"/> 
  <xsl:call-template name="SupplementalDataDefinitionDoc"/>
  <xsl:call-template name="linktop"/>
  <xsl:call-template name="DocGenerationDate"/> 

  <!-- ****************************************************  -->
  <!-- Create the Controlled Terminology (Code Lists),       -->
  <!--  define.xml specification Section 2.1.3.              -->
  <!-- ****************************************************  -->
  <xsl:call-template name="AppendixDecodeList"/>
  <xsl:call-template name="AnnotatedCRF"/> 
  <xsl:call-template name="SupplementalDataDefinitionDoc"/>
  <xsl:call-template name="linktop"/>
  <xsl:call-template name="DocGenerationDate"/> 
</xsl:template>

<!-- ****************************************************  -->
<!-- Template: ItemGroupDef                                -->
<!-- Description: The domain level metadata is represented -->
<!--   by the ODM ItemGroupDef element                     -->
<!-- ****************************************************  -->
<xsl:template name="ItemGroupDef"> 
     <xsl:variable name="itemOID" select="@ItemOID"/>
     <tr align='left' valign='top'>
	  <td><xsl:value-of select="@Name"/></td> 
	  <!-- ************************************************************* -->
	  <!-- Link each XTP to its corresponding section in the define      -->
	  <!-- ************************************************************* -->
	  <td> 
 	    <a>
		<xsl:attribute name="href">
	     	   #<xsl:value-of select="@Name"/>
		</xsl:attribute>
		<xsl:value-of select="@def:Label"/>
 	    </a>
	  </td> 
	  <td>
           <xsl:value-of select="@def:Class"/> - <xsl:value-of select="@def:Structure"/>
        </td> 
	  <td><xsl:value-of select="@Purpose"/>&#160;</td> 
	  <td><xsl:value-of select="@def:DomainKeys"/>&#160;</td> 
	  <!-- ************************************************ -->
	  <!-- Link each XTP to its corresponding archive file  -->
	  <!-- ************************************************ -->
	  <td> 
          <a>
            <xsl:for-each select="def:leaf/@*"> 
                <xsl:variable name="uriattrib" select="name(.)"/>
                <xsl:if test="$uriattrib='xlink:href'">
	               <xsl:attribute name="href">
                           <xsl:value-of select="."/>
	               </xsl:attribute>
                </xsl:if>
            </xsl:for-each>
            <xsl:value-of select="def:leaf/def:title"/>
            </a>
	  </td> 
     </tr>
 </xsl:template>

<!-- **************************************************** -->
<!-- Template: ItemRef                                    -->
<!-- Description: The metadata provided in the Data       -->
<!--    Definition table is represented using the ODM     -->
<!--    ItemRef and ItemDef elements                      -->
<!-- **************************************************** -->
<xsl:template name="ItemRef">
  <!-- ************************************************************* -->
  <!-- This is the target of the internal xpt name links             -->
  <!-- ************************************************************* -->
  <a>
    <xsl:attribute name="Name">
     	   <xsl:value-of select="@Name"/>
    </xsl:attribute>
  </a>
  <table border='2' cellspacing='0' cellpadding='4' width='100%'>
    <tr>
      <!-- Create the column headers -->
      <th colspan='7' align='left' valign='top' height='20'>
	<xsl:value-of select="@def:Label"/> Dataset 
	 (<xsl:value-of select="@Name"/>)<br/> 
    </th>
    </tr>
    <font face='Times New Roman' size='3'/>
    <!-- Output the column headers -->
    <tr align='center'>
      <th align='center' valign='bottom'>Variable</th>
      <th align='center' valign='bottom'>Label</th>
      <th align='center' valign='bottom'>Type</th>
      <th align='center' valign='bottom'>Controlled Terms or Format</th>
      <th align='center' valign='bottom'>Origin</th>
      <th align='center' valign='bottom'>Role</th>
      <th align='center' valign='bottom'>Comment</th>
    </tr>
    <!-- Get the individual data points -->
    <xsl:for-each select="./odm:ItemRef">
      <xsl:variable name="itemDefOid" select="@ItemOID"/>
      <xsl:variable name="itemDef" select="../../odm:ItemDef[@OID=$itemDefOid]"/>
      <tr valign='top'>
 	   <!-- Hypertext link only those variables that have a value list -->
           <td>
		<xsl:choose>
			<xsl:when test="$itemDef/def:ValueListRef/@ValueListOID!=''">
		 	    <a>
				<xsl:attribute name="href">
			     	   #<xsl:value-of select="$itemDef/def:ValueListRef/@ValueListOID"/>
				</xsl:attribute>
				<xsl:value-of select="$itemDef/@Name"/>
		 	    </a>
			</xsl:when>
			<xsl:otherwise>
		     	   <xsl:value-of select="$itemDef/@Name"/>
			</xsl:otherwise>
		</xsl:choose>
	  </td>
        <td><xsl:value-of select="$itemDef/@def:Label"/>&#160;</td>
        <td align='center'><xsl:value-of select="$itemDef/@DataType"/>&#160;</td>
        <td>
  	<xsl:variable name="CODE" select="$itemDef/odm:CodeListRef/@CodeListOID"/>
        <xsl:variable name="CodeListDef" select="/odm:ODM/odm:Study/odm:MetaDataVersion/odm:CodeList[@OID=$CODE]"/>
	<xsl:choose>
		<!-- *************************************************** -->
		<!-- Hypertext Link to the Decode Appendix               -->
		<!-- *************************************************** -->
		<xsl:when test="/odm:ODM/odm:Study/odm:MetaDataVersion/odm:CodeList[@OID=$CODE]">
		 	    <a>
				<xsl:attribute name="href">
			     	   #app3<xsl:value-of select="$CodeListDef/@OID"/>
				</xsl:attribute>
				<xsl:value-of select="$CodeListDef/@OID"/>
		 	    </a>
		</xsl:when>
		<xsl:otherwise>
	     		<xsl:value-of select="$itemDef/odm:CodeListRef/@CodeListOID"/>&#160;
		</xsl:otherwise>
	</xsl:choose>
	<!-- *************************************************** -->
	</td>

	<!-- *************************************************** -->
	<!-- Origin Column                                       -->
	<!-- *************************************************** -->
      <td><xsl:value-of select="$itemDef/@Origin"/>&#160;</td>

	<!-- *************************************************** -->
	<!-- Role Column                                         -->
	<!-- *************************************************** -->
      <td><xsl:value-of select="@Role"/>&#160;</td>

	<!-- *************************************************** -->
	<!-- Comments                                            -->
	<!-- *************************************************** -->
        <td><xsl:value-of select="$itemDef/@Comment"/>&#160;
		<xsl:if test="$itemDef/@def:ComputationMethodOID"> Computational Algorithm:
               <a>
		    <xsl:attribute name="href">
			#<xsl:value-of select="$itemDef/@def:ComputationMethodOID"/>
		    </xsl:attribute>
	   	    <xsl:value-of select="$itemDef/@def:ComputationMethodOID"/>
               </a>
		</xsl:if>
        </td>
      </tr>
</xsl:for-each>
</table>
</xsl:template>

<!-- *************************************************************** -->
<!-- Template: AppendixValueList                                     -->
<!-- Description: This template creates the define.xml specification -->
<!--   Section 2.1.4: Value Level Metadata (Value List)              -->
<!-- *************************************************************** -->
<xsl:template name="AppendixValueList">
<table border='2' cellspacing='0' cellpadding='4'>
  <tr>
    <th colspan='9' align='left' valign='top' height='20'>Value Level Metadata</th>
  </tr>
  <font face='Times New Roman' size='3'/>
  <tr align='center'>
    <th align='center' valign='bottom'>Source Variable</th> 
    <th align='center' valign='bottom'>Value</th>
    <th align='center' valign='bottom'>Label</th>
    <th align='center' valign='bottom'>Type</th>
    <th align='center' valign='bottom'>Controlled Terms or Format</th>
    <th align='center' valign='bottom'>Origin</th>
    <th align='center' valign='bottom'>Role</th>
    <th align='center' valign='bottom'>Comment</th>
  </tr>
  <!-- Get the individual data points -->
    <xsl:for-each select="/odm:ODM/odm:Study/odm:MetaDataVersion/def:ValueListDef/odm:ItemRef">
      <xsl:variable name="valueDefOid" select="@ItemOID"/>
      <xsl:variable name="valueDef" select="../../odm:ItemDef[@OID=$valueDefOid]"/>
      <xsl:variable name="parentOID" select="../@OID"/>
      <xsl:variable name="parentDef" select="../../odm:ItemDef/def:ValueListRef[@ValueListOID=$parentOID]"/>
      <tr>
        <td>
	    <!-- Create the target from to link from the data table -->
  	    <a>
    		<xsl:attribute name="Name">
     	   		<xsl:value-of select="$parentOID"/>
		</xsl:attribute>
  	    </a>
	    <xsl:value-of select="$parentDef/../@Name"/>
	  </td>
        <td><xsl:value-of select="$valueDef/@Name"/></td>
        <td><xsl:value-of select="$valueDef/@def:Label"/>&#160;</td>
        <td align='center'><xsl:value-of select="$valueDef/@DataType"/>&#160;</td>
        <td>
	<!-- *************************************************** -->
	<!-- Hypertext Link to the Decode Appendix               -->
	<!-- *************************************************** -->
	<xsl:choose>
		<xsl:when test="$valueDef/odm:CodeListRef/@CodeListOID!=''">
			<a>
			<xsl:attribute name="href">
			     	   #app3<xsl:value-of select="$valueDef/odm:CodeListRef/@CodeListOID"/>
			</xsl:attribute>
			<xsl:value-of select="$valueDef/odm:CodeListRef/@CodeListOID"/>
		 	</a>
		</xsl:when>
		<xsl:otherwise>
	     		<xsl:value-of select="$valueDef/odm:CodeListRef/@CodeListOID"/>&#160;
		</xsl:otherwise>
	</xsl:choose>
	<!-- *************************************************** -->
	</td>
        <td><xsl:value-of select="$valueDef/@Origin"/>&#160;</td>
        <td><xsl:value-of select="$valueDef/@Role"/>&#160;</td>
        <td><xsl:value-of select="$valueDef/@Comment"/>&#160;
		<xsl:if test="$valueDef/@def:ComputationMethodOID">See Computational Method:
               <a>
		    <xsl:attribute name="href">
			#<xsl:value-of select="$valueDef/@def:ComputationMethodOID"/>
		    </xsl:attribute>
	   	    <xsl:value-of select="$valueDef/@def:ComputationMethodOID"/>
               </a>
		</xsl:if>
        </td>
      </tr>
    </xsl:for-each>
</table>
</xsl:template>

<!-- *************************************************************** -->
<!-- Template: AppendixComputationMethod                             -->
<!-- Description: This template creates the define.xml specification -->
<!--   Section 2.1.5: Computational Algorithms                       -->
<!-- *************************************************************** -->
<xsl:template name="AppendixComputationMethod">
<table  border='2' cellspacing='0' cellpadding='4'>
  <tr> 
    <th colspan='2' align='left' valign='top' height='20'>Computational Algorithms Section</th>
  </tr>
  <font face='Times New Roman' size='3'/>
  <tr align='center'>
    <th>Reference Name</th> 
    <th>Computation Method</th> 
  </tr>
  <xsl:for-each select="/odm:ODM/odm:Study/odm:MetaDataVersion/def:ComputationMethod">
     <tr align='left'>
	  <td>
	    <!-- Create an archer -->
     	    <a>
    		<xsl:attribute name="Name">
     	   		<xsl:value-of select="@OID"/>
		</xsl:attribute>
  	    </a>
	    <xsl:value-of select="@OID"/>
	  </td> 
	  <td> <xsl:value-of select="."/> </td>
      </tr>
  </xsl:for-each>
</table>
</xsl:template>

<!-- *************************************************************** -->
<!-- Template: AppendixDecodeList                                    -->
<!-- Description: This template creates the define.xml specification -->
<!--   Section 2.1.3: Controlled Terminology (Code Lists)            -->
<!-- *************************************************************** -->
<xsl:template name="AppendixDecodeList">
 <table  border='2' cellspacing='0' cellpadding='4'>
  <tr> 
    <th colspan='2' align='left' valign='top' height='20'>Controlled Terminology (Code Lists) Section</th>
  </tr>
  <font face='Times New Roman' size='3'/>
  <tr align='center'>
    <th>Code Value</th> 
    <th>Code Text </th>
  </tr>
  <xsl:for-each select="/odm:ODM/odm:Study/odm:MetaDataVersion/odm:CodeList">
     <tr align='left'>
	  <td colspan='2'>
	  	<!-- Create an archer -->
	  	<a>
    		   <xsl:attribute name="Name">app3<xsl:value-of select="@OID"/></xsl:attribute>&#160;
	  	</a><xsl:value-of select="@Name"/>, Reference Name (<xsl:value-of select="@OID"/>)
	  </td> 
     </tr>
       <xsl:for-each select="./odm:CodeListItem">
           <tr>
		  <td> <xsl:value-of select="@CodedValue"/> </td>
	  	  <td> <xsl:value-of select="./odm:Decode/odm:TranslatedText"/> </td>
            </tr>
	  </xsl:for-each>
     	  <xsl:for-each select="odm:ExternalCodeList/@Dictionary">
          <tr>
		<td><xsl:value-of select="."/></td>
            <td>N/A </td>
          </tr>
	  </xsl:for-each>
  </xsl:for-each>
 </table>
</xsl:template>

<!-- ************************************************************* -->
<!-- Template: AnnotatedCRF                                        -->
<!-- Description: This template creates CRF hypertexted footnote   -->
<!-- ************************************************************* -->
<xsl:template name="AnnotatedCRF">
  <xsl:if test="/odm:ODM/odm:Study/odm:MetaDataVersion/def:AnnotatedCRF">
    <xsl:for-each select="/odm:ODM/odm:Study/odm:MetaDataVersion/def:AnnotatedCRF/def:DocumentRef">
      <xsl:variable name="leafIDs" select="@leafID"/>
        <xsl:variable name="leaf" select="../../def:leaf[@ID=$leafIDs]"/>
        <xsl:for-each select="$leaf/@*"> 
            <xsl:variable name="uriattrib" select="name(.)"/>
            <xsl:if test="$uriattrib='xlink:href'">
                    <p align="left">
                      <xsl:value-of select="$leaf/def:title"/>
                      (<a>
                              <xsl:attribute name="href">
                                 <xsl:value-of select="."/>
                              </xsl:attribute>
                              <xsl:value-of select="."/>
                      </a>)
                    </p>
            </xsl:if>
        </xsl:for-each>
   </xsl:for-each>
  </xsl:if>
</xsl:template>

<!-- ************************************************************* -->
<!-- Template: SupplementalDataDefinitionDoc                       -->
<!-- Description: This template creates the hypertexted footnote   -->
<!-- ************************************************************* -->
<xsl:template name="SupplementalDataDefinitionDoc">
  <xsl:if test="/odm:ODM/odm:Study/odm:MetaDataVersion/def:SupplementalDoc">
    <xsl:for-each select="/odm:ODM/odm:Study/odm:MetaDataVersion/def:SupplementalDoc/def:DocumentRef">
      <xsl:variable name="leafIDs" select="@leafID"/>
        <xsl:variable name="leaf" select="../../def:leaf[@ID=$leafIDs]"/>
        <xsl:for-each select="$leaf/@*"> 
            <xsl:variable name="uriattrib" select="name(.)"/>
            <xsl:if test="$uriattrib='xlink:href'">
                    <p align="left">
                      <xsl:value-of select="$leaf/def:title"/>
                      (<a>
                              <xsl:attribute name="href">
                                 <xsl:value-of select="."/>
                              </xsl:attribute>
                              <xsl:value-of select="."/>
                      </a>)
                    </p>
            </xsl:if>
        </xsl:for-each>
   </xsl:for-each>
  </xsl:if>
</xsl:template>

<!-- ************************************************************* -->
<!-- Template: linktop                                             -->
<!-- Description: This template creates the hypertexted footnote   -->
<!-- ************************************************************* -->
<xsl:template name="linktop">
  <p align='left'>Go to the top of the <a href="#TOP">define.xml</a></p>
</xsl:template>

<!-- ************************************************************* -->
<!-- Template: DocGenerationDate                                   -->
<!-- Description: This template creates the Document Date footnote -->
<!-- ************************************************************* -->
<xsl:template name="DocGenerationDate">
<p align='left'>Date of document generation
	(<xsl:value-of select="/odm:ODM/@CreationDateTime"/>)</p>
<br/>
<br/>
<br/>
</xsl:template>
</xsl:stylesheet>