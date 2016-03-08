# Haun Avaamispäivämäärä 14.10.
# Haun Aloituspäivämäärä 14.10.
# Lopetuspäivämäärä 22.10. kello 12:00
# Toimielimien kausiksi 1.1.2014 – 31.12.2015

def create_call(names, member_amount, organ_desc)
  university = Organization.roots.where(key: 'helsinki').first
  organ = Organ.create!(name: names,
                        organization: university,
                        official: true,
                        description: organ_desc,
                        term_start: Date.parse('1-1-2014'),
                        term_end: Date.parse('31-12-2015')
                       )
  Call.create!(member_amount: member_amount,
               deputy_amount: member_amount,
               title: names,
               workflow: :workflow_administration_election,
               organ_id: organ.id,
               date_start: Date.parse('14-10-2013'),
               date_open: Date.parse('14-10-2013'),
               date_end: Date.parse('22-10-2013')
              )
end

# tiedekuntaneuvostot

organ_description1 = {
  en: 'The Faculty Council is a multi-member administrative body of the faculty, chaired by the Dean. The Faculty Council is responsible for developing teaching and research of the faculty, being in charge of quality management of research and teaching, deciding on degree requirements, curriculum and student selection criteria, among other things, as well as addressing far-reaching plans and other important matters of principle at the faculty.',
  fi: "Tiedekuntaneuvosto on tiedekunnan monijäseninen hallintoelin, jonka puheenjohtajana toimii dekaani. Tiedekuntaneuvoston tehtävänä on kehittää tiedekunnan opetusta ja tutkimusta, vastata tutkimuksen ja opetuksen laadun hallinnasta, päättää mm. tutkintovaatimuksista, opetusohjelmasta, opiskelijoiden valinnan perusteista sekä käsitellä tiedekunnan laajakantoiset suunnitelmat ja muut periaatteellisesti tärkeät asiat.",
  sv: "Fakultetsrådet är fakultetens kollegiala förvaltningsorgan, där dekanus fungerar som ordförande. Fakultetsrådets uppgift är att utveckla undervisning och forskning vid fakulteten, ansvara för kvalitetsledningen inom forskning och undervisning, besluta bl.a. om examensfordringar, undervisningsprogram, grunderna för studentantagningen samt behandla fakultetens långsiktiga planer och andra principiellt viktiga ärenden."
}

teo_names = { fi: 'Teologisen tiedekunnan tiedekuntaneuvosto', sv: "Teologiska fakultetens fakultetsråd", en: 'Faculty Council of Faculty of Theology' }
create_call(teo_names, 3, organ_description1)

oik_names = { fi: 'Oikeustieteellisen tiedekunnan tiedekuntaneuvosto', sv: "Juridiska fakultetens fakultetsråd", en: 'Faculty Council of the Faculty of Law' }
create_call(oik_names, 5, organ_description1)

laak_names = { fi: "Lääketieteellisen tiedekunnan tiedekuntaneuvosto", sv: "Medicinska fakultetens fakultetsråd", en: 'Faculty Council of the Faculty of Medicine' }
create_call(laak_names, 5, organ_description1)

hum_names = { fi: 'Humanistisen tiedekunnan tiedekuntaneuvosto', sv: "Humanistiska fakultetens fakultetsråd", en: 'Faculty Council of the Faculty of Arts' }
create_call(hum_names, 5, organ_description1)

matlu_names = { fi: 'Matemaattis-luonnontieteellisen tiedekunnan tiedekuntaneuvosto', sv: "Matematisk-naturvetenskpaliga fakultetens fakultetsråd", en: 'Faculty Council of the Faculty of Science' }
create_call(matlu_names, 5, organ_description1)

farm_names = { fi: 'Farmasian tiedekunnan tiedekuntaneuvosto', sv: "Farmaceutiska fakultetens fakultetsråd", en: 'Faculty Council of the Faculty of Pharmacy' }
create_call(farm_names, 3, organ_description1)

bio_names = { fi: "Bio- ja ympäristötieteellisen tiedekunnan tiedekuntaneuvosto", sv: "Bio- och miljövetenskapliga fakultetens fakultetsråd", en: ' Faculty Council of the Faculty of Biological and Enviromental Sciences' }
create_call(bio_names, 3, organ_description1)

kayt_names = { fi: "Käyttäytymistieteellisen tiedekunnan tiedekuntaneuvosto", sv: "Beteendevetenskapliga fakultetens fakultetsråd", en: 'Faculty Council of the Faculty of Behavioural Sciences' }
create_call(kayt_names, 5, organ_description1)

valt_names = { fi: 'Valtiotieteellisen tiedekunnan tiedekuntaneuvosto', sv: "Statsvetenskapliga fakultetens fakultetsråd", en: ' Faculty Council of the Faculty of Social Sciences' }
create_call(valt_names, 5, organ_description1)

maat_names = { fi: "Maatalous-metsätieteellisen tiedekunnan tiedekuntaneuvosto", sv: "Agrikultur-forstvetenskapliga fakultetens fakultetsråd", en: 'Faculty of Agriculture and Forestry' }
create_call(maat_names, 5, organ_description1)

elaak_names = { fi: "Eläinlääketieteellisen tiedekunnan tiedekuntaneuvosto", sv: " Veterinärmedicinska fakultetens fakultetsråd", en: 'Faculty Council of the Faculty of Veterinary Medicine' }
create_call(elaak_names, 3, organ_description1)

# laitosneuvostot

organ_description2 = {
  fi: 'Laitosneuvosto on laitoksen monijäseninen hallintoelin, jonka puheenjohtajana toimii laitoksen johtaja. Laitosneuvoston tehtävänä on kehittää laitoksen opetusta ja tutkimusta, vastata osaltaan tutkimuksen ja opetuksen laadun hallinnasta, käsitellä laitoksen toimintasuunnitelma sekä siihen sisältyvä henkilöstösuunnitelma ja laitoksen talousarvio sekä ratkaista laitoksen kannalta laajakantoiset tai periaatteellisesti tärkeät asiat, jotka laitoksen johtaja on saattanut laitosneuvoston käsiteltäväksi.',
  sv: 'Institutionsrådet är institutionens kollegiala förvaltningsorgan, där institutionens prefekt fungerar som ordförande. Institutionsrådet har till uppgift att utveckla undervisning och forskning vid institutionen, för sin del ansvara för kvalitetsledningen inom forskning och undervisning, behandla institutionens verksamhetsplan samt den personalplan och budget som ingår i den samt avgöra ärenden som är vittsyftande eller principiellt viktiga för institutionen och som prefekten har hänskjutit till institutionsrådet',
  en: "The Department Council is a multi-member administrative body of the department, chaired by the Head of the Department. The Department Council is responsible for developing teaching and research of the department, partly being in charge of quality management of research and teaching, drafting the department's action plan and the included personnel plan and the department's budget, as well as resolving far-reaching and important matters of principle concerning the department, which the Head of the Department has assigned to the Department Council."
}

biol_inst_names = { fi: "Biolääketieteen laitoksen laitosneuvosto", sv: "Institutionsrådet för Biomedicinska institutionen", en: 'The Institute Council for Institute of Biomedicine' }
create_call(biol_inst_names, 4, organ_description2)

ham_inst_names = { fi: "Hammaslääketieteen laitoksen laitosneuvosto", sv: " Institutionsrådet för Institutionen för odontologi", en: 'The Institute Council for Institute of Dentistry' }
create_call(ham_inst_names, 3, organ_description2)

kli_inst_names = { fi: 'Kliinisen laitoksen laitosneuvosto', sv: "Institutionsrådet för Institutionen för klinisk medicin", en: 'The Institute Council for Institue of Clinical Science' }
create_call(kli_inst_names, 5, organ_description2)

kliteo_inst_names = { fi: 'Kliinisteoreettisen laitoksen laitosneuvosto', sv: "Institutionsrådet för Haartman-institutet", en: 'The Institute Council for Haartman Institute' }
create_call(kliteo_inst_names, 3, organ_description2)

hje_inst_names = { fi: 'Hjelt-instituutin laitosneuvosto', sv: " Institutionsrådet för Hjelt-institutet", en: 'The Institute Council for Hjelt Institute' }
create_call(hje_inst_names, 4, organ_description2)

suom_inst_names = { fi: 'Suomen kielen, suomalais-ugrilaisten ja pohjoismaisten kielten ja kulttuurien laitoksen laitosneuvosto', sv: " Institutionsrådet för Finska, finskugriska och nordiska institutionen", en: 'The Institute Council for Department of Finnish, Finno-Ugrian and Scandinavian Studies' }
create_call(suom_inst_names, 4, organ_description2)

nykk_inst_names = { fi: 'Nykykielten laitoksen laitosneuvosto', sv: "Institutionsrådet för Institutionen för moderna språk", en: 'The Institute Council for Department of Modern Languages' }
create_call(nykk_inst_names, 4, organ_description2)

maku_inst_names = { fi: 'Maailman kulttuurien laitoksen laitosneuvosto', sv: "Institutionsrådet för Institutionen för världens kulturer", en: 'The Institute Council for Department of World Cultures' }
create_call(maku_inst_names, 3, organ_description2)

filo_inst_names = { fi: 'Filosofian, historian, kulttuurin ja taiteiden tutkimuksen laitoksen laitosneuvosto', sv: " Institutionsrådet för Institutionen för filosofi, historia, kultur- och konstforsking", en: 'The Institute Council for Department of Philosophy, History, Culture and Art Studies' }
create_call(filo_inst_names, 4, organ_description2)

fy_inst_names = { fi: 'Fysiikan laitoksen laitosneuvosto', sv: "Institutionsrådet Institutionen för fysik", en: 'The Institute Council for The Department of Physics' }
create_call(fy_inst_names, 4, organ_description2)

geo_inst_names = { fi: 'Geotieteiden ja maantieteen laitoksen laitosneuvosto', sv: "Institutionsrådet för Institutionen för geovetenskaper och geografi", en: 'The Institute Council for Department of Geosciences and Geography' }
create_call(geo_inst_names, 5, organ_description2)

kem_inst_names = { fi: 'Kemian laitoksen laitosneuvosto', sv: "Institutionsrådet för Kemiska institutionen", en: 'The Institute Council for The Department of Chemistry' }
create_call(kem_inst_names, 4, organ_description2)

mat_names = { fi: 'Matematiikan ja tilastotieteen laitoksen laitosneuvosto', sv: "Institutionsrådet för Institutionen för matematik och statistik", en: 'The Institute Council for Department of Mathematics and Statistics' }
create_call(mat_names, 3, organ_description2)

tktl_inst_names = { fi: "Tietojenkäsittelytieteen laitoksen laitosneuvosto", sv: "Institutionsrådet för Institutionen för dataveteskap", en: 'The Institute Council for Department of Computer Science' }
create_call(tktl_inst_names, 3, organ_description2)

biot_inst_names = { fi: 'Biotieteiden laitoksen laitosneuvosto', sv: "Institutionsrådet för Biovetenskapliga institutionen", en: 'The Institute Council for The Department of Biosciences' }
create_call(biot_inst_names, 4, organ_description2)

ymp_inst_names = { fi: "Ympäristötieteiden laitoksen laitosneuvosto", sv: "Institutionsrådet för Miljövetenskapliga institutionen", en: 'The Institute Council for The Department of Enviromental Sciences' }
create_call(ymp_inst_names, 3, organ_description2)

ope_inst_names = { fi: 'Opettajankoulutuslaitoksen laitoksen laitosneuvosto', sv: "Institutionsrådet för Institutionen för lärarutbildning", en: 'The Institute Council for Department of Teacher Education' }
create_call(ope_inst_names, 5, organ_description2)

kayt_inst_names = { fi: "Käyttäytymistieteiden laitoksen laitosneuvosto", sv: "Institutionsrådet för Institutionen för beteendevetenskaper", en: 'The Institute Council for The Institute of Behavioural Sciences' }
create_call(kayt_inst_names, 5, organ_description2)

sos_inst_names = { fi: 'Sosiaalitieteiden laitoksen laitosneuvosto', sv: "Institutionsrådet för Institutionen för socialvetenskap", en: 'The Institute Council for the Department of Social Research' }
create_call(sos_inst_names, 5, organ_description2)

pol_inst_names = { fi: 'Politiikan ja talouden tutkimuksen laitoksen laitosneuvosto', sv: "Institutionsrådet för Institutionen för politik och ekonomi", en: 'The Institute Council for The Department of Political and Economic Studies' }
create_call(pol_inst_names, 5, organ_description2)

el_inst_names = { fi: "Elintarvike- ja ympäristötieteiden laitoksen laitosneuvosto", sv: "Institutionsrådet för Institutionen för livsmedes- och miljövetenskaper", en: 'The Institute Council for The Department of Food and Enviromental Sciences' }
create_call(el_inst_names, 5, organ_description2)

agri_inst_names = { fi: 'Maataloustieteiden laitoksen laitosneuvosto', sv: "Institutionsrådet för Institutionen för lantbruksvetenskaper", en: 'The Department of Agricultural Sciences' }
create_call(agri_inst_names, 3, organ_description2)

met_inst_names = { fi: "Metsätieteiden laitoksen laitosneuvosto", sv: "Institutionsrådet för Institutionen för skogsvetenskaper", en: 'The Institute Council for The Department of Forest Sciences' }
create_call(met_inst_names, 4, organ_description2)

tal_inst_names = { fi: 'Taloustieteen laitoksen laitosneuvosto', sv: "Institutionsrådet för Institutionen för ekonomi", en: 'The Institute Council for The Department of Economics and Management' }
create_call(tal_inst_names, 3, organ_description2)
