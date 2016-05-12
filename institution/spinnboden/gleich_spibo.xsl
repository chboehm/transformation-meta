<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 -->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:err="http://www.w3.org/2005/xqt-errors"
	exclude-result-prefixes="xs xdt err fn">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@*[.='']" /><!-- Leere Knoten werden entfernt -->

	<xsl:strip-space elements="*" /><!--Whitespace entfernen -->

	<xsl:template match="Spinnboden">
		<xsl:element name="catalog">
			<xsl:for-each select="Objekt">
				<xsl:if test="objektart[text()='B - Buchtitel']">
					<xsl:element name="record">
						<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
						<xsl:apply-templates select="tagesdatum" />
						<!--vufind und institutionsblock werden hier eingefügt -->
						<xsl:element name="dataset">
							<!--FORMAT -->
							<!--typeOfRessource -->
							<typeOfRessource>
								<xsl:text>text</xsl:text>
							</typeOfRessource>
							<!--format Objektartinformationen -->
							<format>
								<xsl:text>Buch</xsl:text>
							</format>
							<!--documentType -->
							<xsl:choose>
								<xsl:when test="s_x046x__x032x_Einzeltitel_x032x_-B[string-length() != 0]">
									<documentType>
										<xsl:text>Sammelband</xsl:text>
									</documentType>
								</xsl:when>
								<xsl:otherwise>
									<documentType>
										<xsl:text>Monografie</xsl:text>
									</documentType>
								</xsl:otherwise>
							</xsl:choose>
							<!--TITLE -->
							<!--title Titelinformationen -->
							<xsl:apply-templates select="Buchtitel[1][string-length() != 0]" />
							<!--originalTitle -->
							<xsl:apply-templates select="Originaltitel[string-length() != 0]" />
							<!--RESPONSIBLE -->
							<!--author Autorinneninformation -->
							<xsl:apply-templates select="Autorin[string-length() != 0]" />
							<!--editor Herausgeberinneninformationen -->
							<xsl:apply-templates select="HerausgeberIn[string-length() != 0]" />
							<!--PUBLISHING -->
							<!--display / publishDate Jahresangabe -->
							<xsl:apply-templates select="Jahr[1][string-length() != 0]" />
							<!--placeOfPublication Ortsangabe -->
							<xsl:apply-templates select="Ort[string-length() != 0]" />
							<!--publisher Verlagsangabe -->
							<xsl:apply-templates select="Verlag[string-length() != 0]" />
							<!--PHYSICAL INFORMATION -->
							<!--physical Seitenangabe -->
							<xsl:apply-templates select="Umfang[1][string-length() != 0]" />
							<!--specificMaterialDesignation -->
							<xsl:apply-templates select="Ausstattung[1][string-length() != 0]" />
							<!--CONTENTRELATED INFORMATION -->
							<!--subjectTopic Deskriptoren -->
							<xsl:apply-templates select="Deskriptoren[string-length() != 0]" />
							<!--subjectPerson -->
							<xsl:apply-templates select="Personen[string-length() != 0]" />
							<!--subjectGeographic Ortsangaben -->
							<xsl:apply-templates select="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts[string-length() != 0]" />
							<!--description -->
							<xsl:apply-templates select="Annotation[1][string-length() != 0]" />
							<!--OTHER -->
							<!--shelfMark Signatur -->
							<xsl:apply-templates select="Signatur[string-length() != 0]" />
						</xsl:element><!--closing tag dataset -->

						<!--FUNCTIONS -->
						<xsl:apply-templates select="s_x046x__x032x_Einzeltitel_x032x_-B[1][string-length() != 0]" />
					</xsl:element><!--closing tag record -->
				</xsl:if><!--closing tag if in dataset -->
				<xsl:if test="(objektart[text()='BI - Titel (Aufsätze) in Sammelbänden']) and (s_x046x__x032x_Buchtitel)">
					<!--Einzeltitel ohne die Angabe zur Referenz werden nicht mit ausgegeben -->
					<xsl:element name="record">
						<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
						<!--vufind und institutionsblock werden hier eingefügt -->
						<xsl:apply-templates select="tagesdatum" />
						<xsl:element name="dataset">
							<!--variables -->
							<xsl:variable name="relatedID" select="translate(s_x046x__x032x_Buchtitel[1], translate(.,'0123456789', ''), '')" />
							<!--FORMAT -->
							<!--typeOfRessource -->
							<typeOfRessource>
								<xsl:text>text</xsl:text>
							</typeOfRessource>
							<!--format Objektartinformationen -->
							<format>
								<xsl:text>Artikel</xsl:text>
							</format>
							<!--documentType -->
							<documentType>Artikel aus Sammelband</documentType>
							<!--TITLE -->
							<!--title Titelinformationen -->
							<xsl:apply-templates select="Einzeltitel[1][string-length() != 0]" />
							<!--RESPONSIBLE -->
							<!--author Autorinneninformation -->
							<xsl:apply-templates select="Autorin[string-length() != 0]" />
							<!--PUBLISHING -->
							<xsl:choose>
								<xsl:when test="Jahr[1][string-length() != 0]">
									<xsl:apply-templates select="Jahr[1]" />
								</xsl:when>
								<xsl:when test="//Objekt[id=$relatedID]/Jahr[1][string-length() != 0]">
									<displayPublishDate>
										<xsl:value-of select="//Objekt[id=$relatedID]/Jahr[1]" />
									</displayPublishDate>
									<publishDate>
										<xsl:value-of select="translate(//Objekt[id=$relatedID]/Jahr[1], translate(.,'0123456789', ''), '')" />
									</publishDate>
								</xsl:when>
							</xsl:choose>
							<!--placeOfPublication Ortsangabe -->
							<xsl:if test="//Objekt[id=$relatedID]/Ort[string-length() != 0]">
								<placeOfPublication>
									<xsl:value-of select="//Objekt[id=$relatedID]/Ort" />
								</placeOfPublication>
							</xsl:if>
							<!--publisher Verlagsangabe -->
							<xsl:if test="//Objekt[id=$relatedID]/Verlag[string-length() != 0]">
								<publisher>
									<xsl:value-of select="//Objekt[id=$relatedID]/Verlag" />
								</publisher>
							</xsl:if>
							<!--sourceInfo -->
							<xsl:if test="s_x046x__x032x_Buchtitel">
								<sourceInfo>
									<xsl:value-of select="//Objekt[id=$relatedID]/Buchtitel" />
								</sourceInfo>
							</xsl:if>
							<!--PHYSICAL INFORMATION -->
							<!--physical Seitenangabe -->
							<xsl:apply-templates select="Umfang[1][string-length() != 0]" />
							<!--specificMaterialDesignation -->
							<xsl:apply-templates select="Ausstattung[1][string-length() != 0]" />
							<!--CONTENTRELATED INFORMATION -->
							<!--description -->
							<xsl:apply-templates select="Annotation[string-length() != 0]" />
							<!--subjectTopic Deskriptoren -->
							<xsl:apply-templates select="Deskriptoren[string-length() != 0]" />
						</xsl:element><!--closing tag dataset -->
						<!--FUNCTIONS -->
						<xsl:apply-templates select="s_x046x__x032x_Buchtitel[string-length() != 0]" />
					</xsl:element><!--closing tag record -->
				</xsl:if>
				<xsl:if test="(objektart[text()='D - Diplomarbeiten']) and (Titel_x032x_-D)">
					<!--Einzeltitel ohne die Angabe zur Referenz werden nicht mit ausgegeben -->
					<xsl:element name="record">
						<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
						<xsl:apply-templates select="tagesdatum" /><!--vufind und institutionsblock werden hier eingefügt -->
						<xsl:element name="dataset">
							<!--FORMAT -->
							<!--typeOfRessource -->
							<typeOfRessource>
								<xsl:text>text</xsl:text>
							</typeOfRessource>
							<!--format Objektartinformationen -->
							<format>
								<xsl:text>Hochschulschrift</xsl:text>
							</format>
							<!--documentType -->
							<xsl:apply-templates select="Art_x032x_der_x032x_Arbeit[string-length() != 0]" />
							<!--TITLE -->
							<!--title Titelinformationen -->
							<xsl:apply-templates select="Titel_x032x_-D[1][string-length() != 0]" />
							<!--RESPONSIBLE -->
							<!--author Autorinneninformation -->
							<xsl:apply-templates select="Autorin[string-length() != 0]" />
							<!--reviewer Begutachterin -->
							<xsl:apply-templates select="Betreuung_x047x_MentorIn_x058x_[string-length() != 0]" />
							<!--PUBLISHING -->
							<!--display / publishDate Jahresangabe -->
							<xsl:apply-templates select="Jahr[1][string-length() != 0]" />
							<!--placeOfPublication Ortsangabe -->
							<xsl:apply-templates select="Ort_x047x_Verlag_x058x_[string-length() != 0]" />
							<!--CONTENTRELATED INFORMATION -->
							<!--subjectTopic Deskriptoren -->
							<xsl:apply-templates select="Schlagwortliste_x032x_-B[string-length() != 0]" />
							<xsl:apply-templates select="Systematik[string-length() !=0]"/>
							<!--subjectPerson -->
							<xsl:apply-templates select="Personen[string-length() != 0]" />
							<!-- annotation -->
							<xsl:apply-templates select="Uni_x047x_HS[string-length() != 0]"/>
							<xsl:apply-templates select="Fachrichtung[string-length() != 0]"/>
							<xsl:apply-templates select="Bemerkungen[string-length() != 0]"/>
						</xsl:element><!--closing tag dataset -->
					</xsl:element><!--closing tag record -->
				</xsl:if><!--closing tag if in dataset -->
				<xsl:if test="(objektart[text()='Ze - Zeitschriften/Einzeltitel']) and (Einzeltitel) and (s_x046x__x032x_ST)">
					<!--Einzeltitel ohne die Angabe zur Referenz werden nicht mit ausgegeben -->
					<xsl:element name="record">
						<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
						<xsl:apply-templates select="tagesdatum" /><!--vufind und institutionsblock werden hier eingefügt -->
						<xsl:element name="dataset">
							<!--variables -->
							<xsl:variable name="relatedID" select="translate(s_x046x__x032x_ST[1], translate(.,'0123456789', ''), '')" />
							<!--FORMAT -->
							<!--typeOfRessource -->
							<typeOfRessource>
								<xsl:text>text</xsl:text>
							</typeOfRessource>
							<!--format Objektartinformationen -->
							<format>
								<xsl:text>Artikel</xsl:text>
							</format>
							<!--documentType -->
							<documentType>
								<xsl:text>Zeitschriftenartikel</xsl:text>
							</documentType>
							<!--TITLE -->
							<!--title Titelinformationen -->
							<xsl:apply-templates select="Einzeltitel[1][string-length() != 0]" />
							<!--RESPONSIBLE -->
							<!--PUBLISHING -->
							<!--placeOfPublication Ortsangabe -->
							<xsl:if test="//Objekt[id=$relatedID]/Ort[string-length() != 0]">
								<placeOfPublication>
									<xsl:value-of select="//Objekt[id=$relatedID]/Ort" />
								</placeOfPublication>
							</xsl:if>
							<!--publisher Verlagsangabe -->
							<xsl:if test="//Objekt[id=$relatedID]/Verlag[string-length() != 0]">
								<publisher>
									<xsl:value-of select="//Objekt[id=$relatedID]/Verlag" />
								</publisher>
							</xsl:if>
							<!--PHYSICAL INFORMATION -->
							<!--physical Seitenangabe -->
							<xsl:if test="Umfang[string-length() != 0]">
								<physical>
									<xsl:value-of select="translate(Umfang[1], translate(.,'0123456789', ''), '')" />
								</physical>
							</xsl:if>
							<!--CONTENTRELATED INFORMATION -->
							<!--subjectTopic Deskriptoren -->
							<xsl:apply-templates select="Deskriptoren[string-length() != 0]" />
							<!--subjectPerson -->
							<xsl:apply-templates select="Personen[string-length() != 0]" />
							<!--subjectGeographic -->
							<xsl:apply-templates select="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts[string-length() != 0]" />
							<!--description -->
							<xsl:apply-templates select="Annotation[1][string-length() != 0]" />
							<!--issue Heft -->
							<xsl:apply-templates select="Heftnummer_x032x_-Z[string-length() != 0]" />
							<!--volume Jahrgang -->
							<xsl:apply-templates select="Jahrgang[string-length() != 0]" />
							<!--sourfo -->
							<xsl:if test="s_x046x__x032x_ST[string-length() != 0]">
								<sourceInfo>
									<xsl:value-of select="//Objekt[id=$relatedID]/Sammeltitel_x032x_-Zs" />
									<!--<xsl:text> </xsl:text> <xsl:if test="Jahrgang"> <xsl:text> </xsl:text> <xsl:value-of select="Jahrgang" /> </xsl:if> 
										<xsl:if test="Jahr"> <xsl:text>(</xsl:text> <xsl:value-of select="Jahr" /> <xsl:text>)</xsl:text> </xsl:if> <xsl:if test="Heftnummer_x032x_-Z"> 
										<xsl:value-of select="Heftnummer_x032x_-Z" /> </xsl:if> -->
								</sourceInfo>
							</xsl:if>
						</xsl:element><!--closing tag dataset -->
						<!--FUNCTIONS -->
						<xsl:if test="s_x046x__x032x_ST[string-length() != 0]">
							<xsl:apply-templates select="s_x046x__x032x_ST[string-length() != 0]" />
						</xsl:if>
					</xsl:element><!--closing tag record -->
				</xsl:if><!--closing tag if in dataset -->
				<xsl:if test="(objektart[text()='Zs - Zeitschriften/Sammeltitel']) and (Sammeltitel_x032x_-Zs)">
					<!--Einzeltitel ohne die Angabe zur Referenz werden nicht mit ausgegeben -->
					<xsl:element name="record">
						<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
						<xsl:apply-templates select="tagesdatum" /><!--vufind und institutionsblock werden hier eingefügt -->
						<xsl:element name="dataset">
							<!--FORMAT -->
							<!--typeOfRessource -->
							<typeOfRessource>
								<xsl:text>text</xsl:text>
							</typeOfRessource>
							<!--format Objektartinformationen -->
							<format><xsl:text>Periodika</xsl:text></format>
							<searchfilter><xsl:text>Zeitschrift</xsl:text></searchfilter>
							<!--TITLE -->
							<!--title Titelinformationen -->
							<xsl:apply-templates select="Sammeltitel_x032x_-Zs[1][string-length() != 0]" />
							<!--RESPONSIBLE -->
							<!--editor Herausgeberinneninformationen -->
							<xsl:apply-templates select="Hrsg_x032x_-_x032x_Zs[string-length() != 0]" />
							<!--PUBLISHING -->
							<!--displayPublishDate -->
							<xsl:apply-templates select="Ersch_x046x_-zeitraum[string-length() != 0]" />
							<xsl:apply-templates select="Ersch_x046x_-weise[string-length() != 0]" />
							<!--placeOfPublication Ortsangabe -->
							<xsl:apply-templates select="Ort[string-length() != 0]" />
							<xsl:apply-templates select="Erscheinungsland[string-length() != 0]" />
							<!--publisher Verlagsangabe -->
							<xsl:apply-templates select="Verlag[string-length() != 0]" />
							<!-- publishDate -->
							<xsl:apply-templates select="J[string-length() != 0]" />
							<!-- subjectTopic -->
							<xsl:apply-templates select="Kateg_x046x_-Zs[string-length() != 0]"/>
						</xsl:element><!--closing tag dataset -->
						<!--FUNCTIONS -->
						<xsl:choose>
							<xsl:when test="s_x046x__x032x_ET[string-length() != 0]">
								<xsl:apply-templates select="s_x046x__x032x_ET" />
							</xsl:when>
							<xsl:when test="s_x046x__x032x_Hefttitel_x032x_-Zh_x040x_s_x041x_[string-length() != 0]">
								<xsl:apply-templates select="s_x046x__x032x_Hefttitel_x032x_-Zh_x040x_s_x041x_" />
							</xsl:when>
						</xsl:choose>
					</xsl:element><!--closing tag record -->
				</xsl:if><!--closing tag if in dataset -->
				<xsl:if test="(objektart[text()='Zh - Zeitschriften/Hefttitel']) and (Hefttitel_x032x_-Zh)">
					<!--Einzeltitel ohne die Angabe zur Referenz werden nicht mit ausgegeben -->
					<xsl:element name="record">
						<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
						<xsl:apply-templates select="tagesdatum" /><!--vufind und institutionsblock werden hier eingefügt -->
						<xsl:element name="dataset">
							<!--FORMAT -->
							<!--typeOfRessource -->
							<typeOfRessource>
								<xsl:text>text</xsl:text>
							</typeOfRessource>
							<!--format Objektartinformationen -->
							<format><xsl:text>Periodika</xsl:text></format>
							<searchfilter><xsl:text>Zeitschriftenheft</xsl:text></searchfilter>
							<!--documentType -->
							<documentType>
								<xsl:text>Zeitschriftenheft</xsl:text>
							</documentType>
							<!--TITLE -->
							<!--title Titelinformationen -->
							<xsl:apply-templates select="Hefttitel_x032x_-Zh[1][string-length() != 0]" />
							<!--PUBLISHING -->
							<!--display / publishDate Jahresangabe -->
							<xsl:apply-templates select="Jahr[1][string-length() != 0]" />
							<!--CONTENTRELATED INFORMATION -->
							<!--subjectTopic Deskriptoren -->
							<xsl:apply-templates select="Deskriptoren[string-length() != 0]" />
							<!--subjectPerson -->
							<xsl:apply-templates select="Personen[string-length() != 0]" />
							<!--subjectGeographic -->
							<xsl:apply-templates select="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts[string-length() != 0]" />
							<!--issue Heft -->
							<xsl:apply-templates select="Heftnummer_x032x_-Z[1][string-length() != 0]" />
							<!--volume Jahrgang -->
							<xsl:apply-templates select="Jahrgang[1][string-length() != 0]" />
						</xsl:element><!--closing tag dataset -->
						<!--FUNCTIONS -->
						<xsl:apply-templates select="s_x046x__x032x_Sammeltitel_x032x_-Zs_x040x_h_x041x_[string-length() != 0]" />
					</xsl:element><!--closing tag record -->
				</xsl:if><!--closing tag if in dataset -->
				<xsl:if test="objektart[text()='G - Graue Materialien']">
					<xsl:element name="record">
						<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
						<xsl:apply-templates select="tagesdatum" />
						<!--vufind und institutionsblock werden hier eingefügt -->
						<xsl:element name="dataset">
							<!--FORMAT -->
							<!--typeOfRessource -->
							<typeOfRessource>
								<xsl:text>text</xsl:text>
							</typeOfRessource>
							<!--format Objektartinformationen -->
							<!--<format><xsl:text>Graue Materialien</xsl:text></format> -->
							<format>
								<xsl:text>Buch</xsl:text>
							</format>
							<!--documentType -->
							<xsl:apply-templates select="Dokumentenart[string-length() != 0]" />
							<!--TITLE -->
							<!--title Titelinformationen -->
							<xsl:apply-templates select="Titel_x032x_-GP[1][string-length() != 0]" />
							<!--originalTitle -->
							<xsl:apply-templates select="Originaltitel[string-length() != 0]" />
							<!--RESPONSIBLE -->
							<!--author Autorinneninformation -->
							<xsl:apply-templates select="UrheberIn[string-length() != 0]" />
							<!--editor Herausgeberinneninformationen -->
							<xsl:apply-templates select="HerausgeberIn[string-length() != 0]" />
							<!--entity -->
							<xsl:apply-templates select="Organisation[string-length() != 0]" />
							<!--PUBLISHING -->
							<!--display / publishDate Jahresangabe -->
							<xsl:apply-templates select="Jahr[1][string-length() != 0]" />
							<!--placeOfPublication Ortsangabe -->
							<xsl:apply-templates select="Ort[string-length() != 0]" />
							<!--publisher Verlagsangabe -->
							<xsl:apply-templates select="Verlag[string-length() != 0]" />
							<!--PHYSICAL INFORMATION -->
							<!--physical Seitenangabe -->
							<xsl:apply-templates select="Umfang[1][string-length() != 0]" />
							<!--specificMaterialDesignation -->
							<xsl:apply-templates select="Ausstattung[1][string-length() != 0]" />
							<!--CONTENTRELATED INFORMATION -->
							<!--subjectTopic Deskriptoren -->
							<xsl:apply-templates select="Deskriptor_x032x__[string-length() != 0]" />
							<!--subjectPerson -->
							<xsl:apply-templates select="Personen[string-length() != 0]" />
							<!--subjectGeographic Ortsangaben -->
							<xsl:apply-templates select="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts[string-length() != 0]" />
							<!--description -->
							<xsl:apply-templates select="Annotation[1][string-length() != 0]" />
							<!--OTHER -->
							<!--shelfMark Signatur -->
							<xsl:apply-templates select="Signatur[string-length() != 0]" />
						</xsl:element><!--closing tag dataset -->
					</xsl:element><!--closing tag record -->
				</xsl:if><!--closing tag if in dataset -->
				<xsl:if test="objektart[text()='K - Kassetten']">
					<xsl:element name="record">
						<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
						<xsl:apply-templates select="tagesdatum" />
						<!--vufind und institutionsblock werden hier eingefügt -->
						<xsl:element name="dataset">
							<!--FORMAT -->
							<!--typeOfRessource -->
							<typeOfRessource>
								<xsl:text>text</xsl:text>
							</typeOfRessource>
							<!--format Objektartinformationen -->
							<format>
								<xsl:text>Tonträger</xsl:text>
							</format>
							<!--documentType -->
							<xsl:apply-templates select="Dokumentenart[string-length() != 0]" />
							<!--TITLE -->
							<!--title Titelinformationen -->
							<xsl:apply-templates select="Kassettentitel[1][string-length() != 0]" />
							<!--originalTitle -->
							<xsl:apply-templates select="Originaltitel[string-length() != 0]" />
							<!--RESPONSIBLE -->
							<!--author Autorinneninformation -->
							<xsl:apply-templates select="Autorin[string-length() != 0]" />
							<!--editor Herausgeberinneninformationen -->
							<xsl:apply-templates select="HerausgeberIn[string-length() != 0]" />
							<!--contributor -->
							<xsl:apply-templates select="DarstellerIn_x047x_Mitwirkende[string-length() != 0]" />
							<!--entity -->
							<xsl:apply-templates select="Organisation[string-length() != 0]" />
							<!--PUBLISHING -->
							<!--display / publishDate Jahresangabe -->
							<xsl:apply-templates select="Jahr[1][string-length() != 0]" />
							<!--placeOfPublication Ortsangabe -->
							<xsl:apply-templates select="Ort[string-length() != 0]" />
							<!--publisher Verlagsangabe -->
							<xsl:apply-templates select="Verlag[string-length() != 0]" />
							<!--PHYSICAL INFORMATION -->
							<!--physical Seitenangabe -->
							<xsl:apply-templates select="Umfang[1][string-length() != 0]" />
							<!--specificMaterialDesignation -->
							<xsl:apply-templates select="Ausstattung[1][string-length() != 0]" />
							<!--CONTENTRELATED INFORMATION -->
							<!--subjectTopic Deskriptoren -->
							<xsl:apply-templates select="Deskriptor_x032x__[string-length() != 0]" />
							<!--subjectPerson -->
							<xsl:apply-templates select="Personen[string-length() != 0]" />
							<!--subjectGeographic Ortsangaben -->
							<xsl:apply-templates select="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts[string-length() != 0]" />
							<!--description -->
							<xsl:apply-templates select="Inhalt_x047x_Thema[string-length() != 0]" />
							<!--OTHER -->
							<!--shelfMark Signatur -->
							<xsl:apply-templates select="Signatur[string-length() != 0]" />
						</xsl:element><!--closing tag dataset -->
					</xsl:element><!--closing tag record -->
				</xsl:if><!--closing tag if in dataset -->
				<xsl:if test="objektart[text()='P - Plakate']">
					<xsl:element name="record">
						<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
						<xsl:apply-templates select="tagesdatum" />
						<!--vufind und institutionsblock werden hier eingefügt -->
						<xsl:element name="dataset">
							<!--FORMAT -->
							<!--typeOfRessource -->
							<typeOfRessource><xsl:text>image</xsl:text></typeOfRessource>
							<!--format Objektartinformationen -->
							<format><xsl:text>Visuelle Materialien</xsl:text></format>	
							<searchfilter><xsl:text>Plakat</xsl:text></searchfilter>
							<!--documentType -->
							<xsl:apply-templates select="Dokumentenart[string-length() != 0]" />
							<!--TITLE -->
							<!--title Titelinformationen -->
							<xsl:apply-templates select="Titel_x032x_-GP[1][string-length() != 0]" />
							<!--originalTitle -->
							<xsl:apply-templates select="Originaltitel[string-length() != 0]" />
							<!--RESPONSIBLE -->
							<!--author Autorinneninformation -->
							<xsl:apply-templates select="UrheberIn[string-length() != 0]" />
							<!--editor Herausgeberinneninformationen -->
							<xsl:apply-templates select="Hrsg_x032x_-_x032x_P[string-length() != 0]" />
							<!--contributor -->
							<xsl:apply-templates select="DarstellerIn_x047x_Mitwirkende[string-length() != 0]" />
							<!--entity -->
							<xsl:apply-templates select="Organisation[string-length() != 0]" />
							<!--PUBLISHING -->
							<!--display / publishDate Jahresangabe -->
							<xsl:apply-templates select="Jahr[1][string-length() != 0]" />
							<!--placeOfPublication Ortsangabe -->
							<xsl:apply-templates select="Veranst_x046x_-ort[string-length() != 0]" />
							<xsl:apply-templates select="Erscheinungsland[string-length() != 0]" />
							<!--publisher Verlagsangabe -->
							<xsl:apply-templates select="Verlag[string-length() != 0]" />
							<!--PHYSICAL INFORMATION -->
							<!--physical Seitenangabe -->
							<xsl:apply-templates select="Umfang[1][string-length() != 0]" />
							<!--Format -->
							<xsl:apply-templates select="Format[1][string-length() != 0]" />
							<!--specificMaterialDesignation -->
							<xsl:apply-templates select="Ausstattung[1][string-length() != 0]" />
							<!--CONTENTRELATED INFORMATION -->
							<!--subjectTopic Deskriptoren -->
							<xsl:apply-templates select="Deskriptor_x032x__[string-length() != 0]" />
							<!-- annotation -->
							<xsl:apply-templates select="Annotation[string-length() != 0]"/>
							<xsl:apply-templates select="Bemerkungen[string-length() != 0]"/>
							<!--subjectPerson -->
							<xsl:apply-templates select="Personen[string-length() != 0]" />
							<!--subjectGeographic Ortsangaben -->
							<xsl:apply-templates select="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts[string-length() != 0]" />
							<!--description -->
							<xsl:apply-templates select="Inhalt_x047x_Thema[string-length() != 0]" />
							<xsl:apply-templates select="Abbildung[string-length() != 0]" />
							<xsl:apply-templates select="Veranst_x046x_-dat_x046x_[string-length() != 0]"/>
							<!-- subjectTopic Schlagworte -->
							<xsl:apply-templates select="Themenslw[string-length() != 0]"/>
							<!--OTHER -->
							<!--shelfMark Signatur -->
							<xsl:apply-templates select="Signatur[string-length() != 0]" />
						</xsl:element><!--closing tag dataset -->
					</xsl:element><!--closing tag record -->
				</xsl:if><!--closing tag if in dataset -->
				<xsl:if test="objektart[text()='V - Videofilme']">
					<xsl:element name="record">
						<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
						<xsl:apply-templates select="tagesdatum" />
						<!--vufind und institutionsblock werden hier eingefügt -->
						<xsl:element name="dataset">
							<!--FORMAT -->
							<!--typeOfRessource -->
							<typeOfRessource>
								<xsl:text>text</xsl:text>
							</typeOfRessource>
							<!--format Objektartinformationen -->
							<format>
								<xsl:text>Film</xsl:text>
							</format>
							<!--documentType -->
							<xsl:apply-templates select="Art_x032x_der_x032x_Videokassette[string-length() != 0]" />
							<!--TITLE -->
							<!--title Titelinformationen -->
							<xsl:apply-templates select="Filmtitel[string-length() != 0]" />
							<!--originalTitle -->
							<xsl:apply-templates select="Originaltitel[string-length() != 0]" />
							<!--RESPONSIBLE -->
							<!--author Autorinneninformation -->
							<xsl:apply-templates select="RegisseurIn[string-length() != 0]" />
							<!--editor Herausgeberinneninformationen -->
							<xsl:apply-templates select="HerausgeberIn[string-length() != 0]" />
							<!--contributor -->
							<xsl:apply-templates select="DarstellerIn_x047x_Mitwirkende[string-length() != 0]" />
							<xsl:apply-templates select="ModeratorIn[string-length() != 0]" />
							<xsl:apply-templates select="DrehbuchautorIn[string-length() != 0]" />
							<!--entity -->
							<xsl:apply-templates select="Organisation[string-length() != 0]" />
							<!--series -->
							<xsl:apply-templates select="Sendereihe[string-length() != 0]" />
							<!--PUBLISHING -->
							<!--display / publishDate Jahresangabe -->
							<xsl:apply-templates select="Jahr[1][string-length() != 0]" />
							<!--placeOfPublication Ortsangabe -->
							<xsl:apply-templates select="Ort[string-length() != 0]" />
							<!--publisher Verlagsangabe -->
							<xsl:apply-templates select="Sender_x047x_ProduzentIn[string-length() != 0]" />
							<!--PHYSICAL INFORMATION -->
							<!--physical Seitenangabe -->
							<xsl:apply-templates select="Umfang[1][string-length() != 0]" />
							<!--runTime -->
							<xsl:apply-templates select="Spielzeit_x032x__x040x_min_x041x_[string-length() != 0]" />
							<!--Format -->
							<xsl:apply-templates select="Format[1][string-length() != 0]" />
							<!--specificMaterialDesignation -->
							<xsl:apply-templates select="Ausstattung[1][string-length() != 0]" />
							<!--CONTENTRELATED INFORMATION -->
							<!--subjectTopic Deskriptoren -->
							<xsl:apply-templates select="Deskriptoren[string-length() != 0]" />
							<!--subjectPerson -->
							<xsl:apply-templates select="Personen[string-length() != 0]" />
							<!--subjectGeographic Ortsangaben -->
							<xsl:apply-templates select="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts[string-length() != 0]" />
							<!--description -->
							<xsl:apply-templates select="Inhalt_x047x_Thema[string-length() != 0]" />
							<!--OTHER -->
							<!--shelfMark Signatur -->
							<xsl:apply-templates select="Signatur[string-length() != 0]" />
						</xsl:element><!--closing tag dataset -->
					</xsl:element><!--closing tag record -->
				</xsl:if><!--closing tag if in dataset -->
			</xsl:for-each><!--closing tag for-each Schleife datensatz -->
		</xsl:element>
	</xsl:template>
	<!--Templates -->
	<xsl:template match="Sendereihe">
		<series>
			<xsl:value-of select="." />
		</series>
	</xsl:template>

	<xsl:template match="Ersch_x046x_-zeitraum">
		<displayPublishDate>
			<xsl:value-of select="."></xsl:value-of>
		</displayPublishDate>
		<publishDate>
			<xsl:value-of select="."></xsl:value-of>
		</publishDate>
	</xsl:template>

	<xsl:template match="Ersch_x046x_-weise">
		<publicationFrequency>
			<xsl:value-of select="."></xsl:value-of>
		</publicationFrequency>
	</xsl:template>

	<xsl:template match="Jahrgang">
		<volume>
			<xsl:value-of select="." />
		</volume>
	</xsl:template>

	<xsl:template match="Heftnummer_x032x_-Z">
		<issue>
			<xsl:value-of select="." />
		</issue>
	</xsl:template>

	<xsl:template match="Schlagwortliste_x032x_-B">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="." />
			</subjectTopic>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="Systematik">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="." />
			</subjectTopic>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Ort_x047x_Verlag_x058x_">
		<placeOfPublication>
			<xsl:value-of select="." />
		</placeOfPublication>
	</xsl:template>

	<xsl:template match="Betreuung_x047x_MentorIn_x058x_">
		<reviewer>
			<xsl:value-of select="." />
		</reviewer>
	</xsl:template>

	<xsl:template match="Art_x032x_der_x032x_Arbeit">
		<documentType>
			<xsl:value-of select="."></xsl:value-of>
		</documentType>
	</xsl:template>

	<xsl:template match="s_x046x__x032x_Einzeltitel_x032x_-B[1]">
		<xsl:variable name="relatedID" select="translate(.[1], translate(.,'0123456789', ''), '')" />
		<xsl:variable name="relatedTitle" select="//Objekt[id=$relatedID]/Sammeltitel_x032x_-Zs"></xsl:variable>
		<xsl:element name="functions">
			<hierarchyFields>
				<hierarchy_top_id>
					<xsl:value-of select="../id" />
					<xsl:text>spinnboden</xsl:text>
				</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="../Buchtitel" />
				</hierarchy_top_title>
				<is_hierarchy_id>
					<xsl:value-of select="../id" />
					<xsl:text>spinnboden</xsl:text>
				</is_hierarchy_id>
				<is_hierarchy_title>
					<xsl:value-of select="../Buchtitel" />
				</is_hierarchy_title>
			</hierarchyFields>
		</xsl:element>
	</xsl:template>

	<xsl:template match="s_x046x__x032x_ET">
		<xsl:element name="functions">
			<hierarchyFields>
				<hierarchy_top_id>
					<xsl:value-of select="../id" />
					<xsl:text>spinnboden</xsl:text>
				</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="../Sammeltitel_x032x_-Zs" />
				</hierarchy_top_title>
				<is_hierarchy_id>
					<xsl:value-of select="../id" />
					<xsl:text>spinnboden</xsl:text>
				</is_hierarchy_id>
				<is_hierarchy_title>
					<xsl:value-of select="../Sammeltitel_x032x_-Zs" />
				</is_hierarchy_title>
			</hierarchyFields>
		</xsl:element>
	</xsl:template>

	<xsl:template match="s_x046x__x032x_Hefttitel_x032x_-Zh_x040x_s_x041x_">
		<xsl:element name="functions">
			<hierarchyFields>
				<hierarchy_top_id>
					<xsl:value-of select="../id" />
					<xsl:text>spinnboden</xsl:text>
				</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="../Sammeltitel_x032x_-Zs" />
				</hierarchy_top_title>
				<is_hierarchy_id>
					<xsl:value-of select="../id" />
					<xsl:text>spinnboden</xsl:text>
				</is_hierarchy_id>
				<is_hierarchy_title>
					<xsl:value-of select="../Sammeltitel_x032x_-Zs" />
				</is_hierarchy_title>
			</hierarchyFields>
		</xsl:element>
	</xsl:template>

	<xsl:template match="s_x046x__x032x_Sammeltitel_x032x_-Zs_x040x_h_x041x_">
		<xsl:variable name="relatedID" select="translate(.[1], translate(.,'0123456789', ''), '')" />
		<xsl:variable name="relatedTitle" select="//Objekt[id=$relatedID]/Sammeltitel_x032x_-Zs"></xsl:variable>
		<xsl:element name="functions">
			<hierarchyFields>
				<hierarchy_top_id>
					<xsl:value-of select="$relatedID" />
					<xsl:text>spinnboden</xsl:text>
				</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="$relatedTitle" />
				</hierarchy_top_title>
				<hierarchy_parent_id>
					<xsl:value-of select="$relatedID" />
					<xsl:text>spinnboden</xsl:text>
				</hierarchy_parent_id>
				<hierarchy_parent_title>
					<xsl:value-of select="$relatedTitle" />
				</hierarchy_parent_title>
				<is_hierarchy_id>
					<xsl:value-of select="../id" />
					<xsl:text>spinnboden</xsl:text>
				</is_hierarchy_id>
				<is_hierarchy_title>
					<xsl:value-of select="../Hefttitel_x032x_-Zh" />
				</is_hierarchy_title>
				<hierarchy_sequence>
					<xsl:value-of select="../Hefttitel_x032x_-Zh"></xsl:value-of>
				</hierarchy_sequence>
			</hierarchyFields>
		</xsl:element>
	</xsl:template>

	<xsl:template match="s_x046x__x032x_ST">
		<xsl:variable name="relatedID" select="translate(.[1], translate(.,'0123456789', ''), '')" />
		<xsl:variable name="sequence" select="substring-before(../Umfang[1],'-')" />
		<xsl:variable name="relatedTitle" select="//Objekt[id=$relatedID]/Sammeltitel_x032x_-Zs"></xsl:variable>
		<xsl:element name="functions">
			<hierarchyFields>
				<hierarchy_top_id>
					<xsl:value-of select="$relatedID" />
					<xsl:text>spinnboden</xsl:text>
				</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="$relatedTitle" />
				</hierarchy_top_title>
				<hierarchy_parent_id>
					<xsl:value-of select="$relatedID" />
					<xsl:text>spinnboden</xsl:text>
				</hierarchy_parent_id>
				<hierarchy_parent_title>
					<xsl:value-of select="$relatedTitle" />
				</hierarchy_parent_title>
				<is_hierarchy_id>
					<xsl:value-of select="../id" />
					<xsl:text>spinnboden</xsl:text>
				</is_hierarchy_id>
				<is_hierarchy_title>
					<xsl:value-of select="../Einzeltitel" />
				</is_hierarchy_title>
				<hierarchy_sequence>
					<xsl:value-of select="substring(../Einzeltitel,1,3)"></xsl:value-of>
				</hierarchy_sequence>
			</hierarchyFields>
		</xsl:element>
	</xsl:template>

	<xsl:template match="s_x046x__x032x_Buchtitel">
		<xsl:variable name="relatedID" select="translate(.[1], translate(.,'0123456789', ''), '')" />
		<xsl:variable name="relatedTitle" select="//Objekt[id=$relatedID]/Buchtitel"></xsl:variable>
		<xsl:element name="functions">
			<hierarchyFields>
				<hierarchy_top_id>
					<xsl:value-of select="$relatedID" />
					<xsl:text>spinnboden</xsl:text>
				</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="$relatedTitle" />
				</hierarchy_top_title>
				<hierarchy_parent_id>
					<xsl:value-of select="$relatedID" />
					<xsl:text>spinnboden</xsl:text>
				</hierarchy_parent_id>
				<hierarchy_parent_title>
					<xsl:value-of select="$relatedTitle" />
				</hierarchy_parent_title>
				<is_hierarchy_id>
					<xsl:value-of select="../id" />
					<xsl:text>spinnboden</xsl:text>
				</is_hierarchy_id>
				<is_hierarchy_title>
					<xsl:value-of select="../Einzeltitel" />
				</is_hierarchy_title>
				<hierarchy_sequence>
					<xsl:value-of select="substring-after(../Umfang,'S.')"></xsl:value-of>
				</hierarchy_sequence>
			</hierarchyFields>
		</xsl:element>
	</xsl:template>

	<xsl:template match="Originaltitel">
		<originalTitle>
			<xsl:value-of select="." />
		</originalTitle>
	</xsl:template>

	<xsl:template match="Personen">
		<xsl:for-each select=".">
			<subjectPerson>
				<xsl:value-of select="." />
			</subjectPerson>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Standort">
		<itemLocation>
			<xsl:value-of select="." />
		</itemLocation>
	</xsl:template>

	<xsl:template match="Spielzeit_x032x__x040x_min_x041x_">
		<runTime>
			<xsl:value-of select="." />
		</runTime>
	</xsl:template>

	<xsl:template match="Ausstattung">
		<specificMaterialDesignation>
			<xsl:value-of select="." />
		</specificMaterialDesignation>
	</xsl:template>

	<xsl:template match="Umfang[1]">
		<xsl:choose>
			<xsl:when test="../objektart[text()='B - Buchtitel']">
				<physical>
					<xsl:value-of select="normalize-space(substring-before(.,'S.'))"></xsl:value-of>
				</physical>
			</xsl:when>
			<xsl:when test="../objektart[text()='BI - Titel (Aufsätze) in Sammelbänden']">
				<physical>
					<xsl:value-of select="normalize-space(substring-after(.,'S.'))" />
				</physical>
			</xsl:when>
			<xsl:when test="../objektart[text()='Ze - Zeitschriften/Einzeltitel']">
				<physical>
					<xsl:value-of select="normalize-space(substring-after(.,'S.'))" />
				</physical>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="Signatur">
		<shelfMark>
			<xsl:value-of select="." />
		</shelfMark>
	</xsl:template>

	<xsl:template match="Herkunft_x032x__">
		<xsl:for-each select="tokenize(.,';')">
			<subjectGeographic>
				<xsl:value-of select="normalize-space(.)" />
			</subjectGeographic>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts">
		<xsl:for-each select=".">
			<xsl:if test="not(contains(.,'überall'))">
				<subjectGeographic>
					<xsl:value-of select="." />
				</subjectGeographic>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Inhalt_x047x_Thema">
		<description>
			<xsl:value-of select="." />
		</description>
	</xsl:template>

	<xsl:template match="Annotation[1]">
		<description>
			<xsl:value-of select="normalize-space(replace(.,'&lt;NZ&gt;','&lt;br&gt;'))" />
			<!--<xsl:value-of select="." /> -->
		</description>
	</xsl:template>

	<xsl:template match="Art_x032x_der_x032x_Videokassette">
		<documentType>
			<xsl:value-of select="." />
			<xsl:if test="../Filmtyp">
				<xsl:text> - </xsl:text>
				<xsl:value-of select="../Filmtyp" />
			</xsl:if>
		</documentType>
	</xsl:template>

	<xsl:template match="Dokumentenart">
		<documentType>
			<xsl:value-of select="." />
		</documentType>
	</xsl:template>

	<xsl:template match="Deskriptor_x032x__">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="." />
			</subjectTopic>
		</xsl:for-each>
	</xsl:template>


	<xsl:template match="Deskriptoren">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="." />
			</subjectTopic>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Sprache">
		<language>
			<xsl:value-of select="."></xsl:value-of>
		</language>
	</xsl:template>

	<xsl:template match="Format">
		<dimension>
			<xsl:value-of select="."></xsl:value-of>
		</dimension>
	</xsl:template>

	<xsl:template match="Umfang">
		<physical>
			<xsl:value-of select="."></xsl:value-of>
		</physical>
	</xsl:template>

	<xsl:template match="Sender_x047x_ProduzentIn">
		<publisher>
			<xsl:value-of select="." />
		</publisher>
	</xsl:template>

	<xsl:template match="Verlag">
		<publisher>
			<xsl:value-of select="." />
		</publisher>
	</xsl:template>

	<xsl:template match="Ort">
		<placeOfPublication>
			<xsl:value-of select="." />
		</placeOfPublication>
	</xsl:template>

	<xsl:template match="Jahr[1]">
		<displayPublishDate>
			<xsl:value-of select="." />
		</displayPublishDate>
		<publishDate>
			<xsl:value-of select="translate(.[1], translate(.,'0123456789', ''), '')" />
		</publishDate>
	</xsl:template>
	<xsl:template match="J">
		<displayPublishDate>
			<xsl:value-of select="." />
		</displayPublishDate>
		<publishDate>
			<xsl:value-of select="." />
		</publishDate>
	</xsl:template>

	<xsl:template match="RegisseurIn">
		<xsl:for-each select=".">
			<author>
				<xsl:value-of select="." />
			</author>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="DrehbuchautorIn">
		<xsl:for-each select=".">
			<contributor>
				<xsl:value-of select="." />
			</contributor>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="ModeratorIn">
		<xsl:for-each select=".">
			<contributor>
				<xsl:value-of select="." />
			</contributor>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="DarstellerIn_x047x_Mitwirkende">
		<xsl:for-each select=".">
			<contributor>
				<xsl:value-of select="." />
			</contributor>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Organisation">
		<!--<xsl:for-each select="."> -->
		<entity>
			<xsl:value-of select="." />
		</entity>
		<!--</xsl:for-each> -->
	</xsl:template>

	<xsl:template match="Hrsg_x032x_-_x032x_Zs">
		<xsl:for-each select=".">
			<editor>
				<xsl:value-of select="." />
			</editor>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="HerausgeberIn">
		<xsl:for-each select=".">
			<editor>
				<xsl:value-of select="." />
			</editor>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="UrheberIn">
		<xsl:for-each select=".">
			<author>
				<xsl:value-of select="." />
			</author>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Autorin">
		<xsl:for-each select=".">
			<author>
				<xsl:value-of select="." />
			</author>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Sammeltitel_x032x_-Zs[1]">
		<title>
			<xsl:value-of select="normalize-space(.)" />
		</title>
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
		</title_short>
		<xsl:if test="../Untertitel[string-length() != 0]">
			<title_sub>
				<xsl:value-of select="normalize-space(../Untertitel[1])" />
			</title_sub>
		</xsl:if>
	</xsl:template>

	<xsl:template match="Kassettentitel">
		<title>
			<xsl:value-of select="normalize-space(.)" />
		</title>
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
		</title_short>
		<xsl:if test="../Untertitel[string-length() != 0]">
			<title_sub>
				<xsl:value-of select="normalize-space(../Untertitel[1])" />
			</title_sub>
		</xsl:if>
	</xsl:template>

	<xsl:template match="Buchtitel[1]">
		<title>
			<xsl:value-of select="normalize-space(.)" />
		</title>
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
		</title_short>
		<xsl:if test="../Untertitel[string-length() != 0]">
			<title_sub>
				<xsl:value-of select="normalize-space(../Untertitel[1])" />
			</title_sub>
		</xsl:if>
	</xsl:template>

	<xsl:template match="Einzeltitel[1]">
		<title>
			<xsl:value-of select="normalize-space(.)" />
		</title>
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
		</title_short>
		<xsl:if test="../Untertitel[string-length() != 0]">
			<title_sub>
				<xsl:value-of select="normalize-space(../Untertitel[1])" />
			</title_sub>
		</xsl:if>
	</xsl:template>

	<xsl:template match="Titel_x032x_-D[1]">
		<title>
			<xsl:value-of select="normalize-space(.)" />
		</title>
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
		</title_short>
		<xsl:if test="../Untertitel[string-length() != 0]">
			<title_sub>
				<xsl:value-of select="normalize-space(../Untertitel[1])" />
			</title_sub>
		</xsl:if>
	</xsl:template>

	<xsl:template match="Filmtitel">
		<title>
			<xsl:value-of select="normalize-space(.)" />
		</title>
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
		</title_short>
		<xsl:if test="../Untertitel[string-length() != 0]">
			<title_sub>
				<xsl:value-of select="normalize-space(../Untertitel[1])" />
			</title_sub>
		</xsl:if>
	</xsl:template>

	<xsl:template match="Titel_x032x_-GP">
		<title>
			<xsl:value-of select="normalize-space(.)" />
		</title>
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
		</title_short>
		<xsl:if test="../Untertitel[string-length() != 0]">
			<title_sub>
				<xsl:value-of select="normalize-space(../Untertitel[1])" />
			</title_sub>
		</xsl:if>
	</xsl:template>


	<xsl:template match="Hefttitel_x032x_-Zh[1]">
		<title>
			<xsl:value-of select="normalize-space(.)" />
			<xsl:text> (</xsl:text>
			<xsl:value-of select="Jahr" />
			<xsl:text>)</xsl:text>
			<xsl:value-of select="Heftnummer_x032x_-Z" />
		</title>
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
		</title_short>
		<xsl:if test="../Untertitel[string-length() != 0]">
			<title_sub>
				<xsl:value-of select="normalize-space(../Untertitel[1])" />
			</title_sub>
		</xsl:if>
	</xsl:template>

	<xsl:template match="tagesdatum">
		<xsl:variable name="id" select="../id" />
		<xsl:element name="vufind">
			<!--Identifikator -->
			<id>
				<xsl:value-of select="$id" />
				<xsl:text>spinnboden</xsl:text>
			</id>
			<!--recordCreationDate -->
			<recordCreationDate>
				<xsl:value-of select="current-dateTime()" />
			</recordCreationDate>
			<!--recordChangeDate -->
			<recordChangeDate>
				<xsl:value-of select="current-dateTime()" />
			</recordChangeDate>
			<!--recordType -->
			<recordType>
				<xsl:text>library</xsl:text>
			</recordType>
		</xsl:element>

		<xsl:element name="institution">
			<!--institutionShortname -->
			<institutionShortname>
				<xsl:text>Spinnboden</xsl:text>
			</institutionShortname>
			<!--institutionFullname -->
			<institutionFull>
				<xsl:text>Spinnboden - Lesbenarchiv und Bibliothek</xsl:text>
			</institutionFull>
			<!--institutionID -->
			<institutionID>
				<xsl:text>spinnboden</xsl:text>
			</institutionID>
			<!--collection -->
			<collection>
				<xsl:text>Spinnboden</xsl:text>
			</collection>
			<!--isil -->
			<isil>
				<xsl:text>DE-B1544</xsl:text>
			</isil>
			<!--linkToWebpage -->
			<link>
				<xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/spinnboden/</xsl:text>
			</link>
			<!--geoLocation -->
			<geoLocation>
				<latitude>52.5353200</latitude>
				<longitude>13.3991900</longitude>
			</geoLocation>
		</xsl:element>
	</xsl:template>
	
	<!-- sp 03.05.2016 -->
	<xsl:template match="Abbildung">
		<description>
			<xsl:value-of select="." />
		</description>
	</xsl:template>
	<xsl:template match="Bemerkungen">
		<annotation>
			<xsl:value-of select="." />
		</annotation>
	</xsl:template>
	<xsl:template match="Veranst_x046x_-dat_x046x_">
		<description>
			<xsl:value-of select="concat('Veranstaltungsdatum: ',.)" />
		</description>
	</xsl:template>
	<xsl:template match="Erscheinungsland">
		<placeOfPublication>
			<xsl:value-of select="." />
		</placeOfPublication>
	</xsl:template>
	<xsl:template match="Veranst_x046x_-ort">
		<placeOfPublication>
			<xsl:value-of select="." />
		</placeOfPublication>
	</xsl:template>
	<xsl:template match="Themenslw">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="." />
			</subjectTopic>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Kateg_x046x_-Zs">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="." />
			</subjectTopic>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Hrsg_x032x_-_x032x_P">
		<xsl:for-each select=".">
			<editor>
				<xsl:value-of select="." />
			</editor>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Uni_x047x_HS">
		<annotation>
			<xsl:text>Hochschule: </xsl:text>
			<xsl:value-of select="." />
		</annotation>
	</xsl:template>
	<xsl:template match="Fachrichtung">
		<annotation>
			<xsl:text>Fachrichtung: </xsl:text>
			<xsl:value-of select="." />
		</annotation>
	</xsl:template>
</xsl:stylesheet>