#Haun Avaamispäivämäärä 5.10.
# Haun Aloituspäivämäärä 5.10.
#Lopetuspäivämäärä 15.10. kello 12:00
#Toimielimien kausiksi 1.1.2016 – 31.12.2017

@test_finding = false

def create_call(organ_finnish, member_amount)
  organ = Organ.find_by('name.fi' => organ_finnish)
  call_titles = Hash[o.name_translations.map { |k,n| [k, "#{n} 2015"] }]
  unless @test_finding
    Call.create!(member_amount: member_amount,
                 deputy_amount: member_amount,
                 title: call_titles,
                 workflow: :workflow_administration_election,
                 organ_id: organ.id,
                 date_start: Date.parse('2015-10-05'),
                 date_open: Date.parse('2015-10-05'),
                 date_end: Date.parse('2015-10-15'),
                 term_start: Date.parse('2016-01-01'),
                 term_end: Date.parse('2017-12-31')
    )
  end
end

#tiedekuntaneuvostot

teo_finnish = "Teologisen tiedekunnan tiedekuntaneuvosto"
create_call(teo_finnish, 3)

oik_finnish = "Oikeustieteellisen tiedekunnan tiedekuntaneuvosto"
create_call(oik_finnish, 5)

laak_finnish = "Lääketieteellisen tiedekunnan tiedekuntaneuvosto"
create_call(laak_finnish, 5)

hum_finnish = "Humanistisen tiedekunnan tiedekuntaneuvosto"
create_call(hum_names, 5)

matlu_names = "Matemaattis-luonnontieteellisen tiedekunnan tiedekuntaneuvosto"
create_call(matlu_names, 5)

farm_names = "Farmasian tiedekunnan tiedekuntaneuvosto"
create_call(farm_names, 3)

bio_names = "Bio- ja ympäristötieteellisen tiedekunnan tiedekuntaneuvosto"
create_call(bio_names, 3)

kayt_names = "Käyttäytymistieteellisen tiedekunnan tiedekuntaneuvosto"
create_call(kayt_names, 5)

valt_names = "Valtiotieteellisen tiedekunnan tiedekuntaneuvosto"
create_call(valt_names, 5)

maat_names = "Maatalous-metsätieteellisen tiedekunnan tiedekuntaneuvosto"
create_call(maat_names, 5)

elaak_names = "Eläinlääketieteellisen tiedekunnan tiedekuntaneuvosto"
create_call(elaak_names, 3)

#laitosneuvostot

suom_inst_names = "Suomen kielen, suomalais-ugrilaisten ja pohjoismaisten kielten ja kulttuurien laitoksen laitosneuvosto"
create_call(suom_inst_names, 4)

nykk_inst_names = "Nykykielten laitoksen laitosneuvosto"
create_call(nykk_inst_names, 4)

maku_inst_names = "Maailman kulttuurien laitoksen laitosneuvosto"
create_call(maku_inst_names, 3)

filo_inst_names = "Filosofian, historian, kulttuurin ja taiteiden tutkimuksen laitoksen laitosneuvosto"
create_call(filo_inst_names, 4)

fy_inst_names = "Fysiikan laitoksen laitosneuvosto"
create_call(fy_inst_names, 4)

geo_inst_names = "Geotieteiden ja maantieteen laitoksen laitosneuvosto"
create_call(geo_inst_names, 5)

kem_inst_names = "Kemian laitoksen laitosneuvosto"
create_call(kem_inst_names, 4)

mat_names = "Matematiikan ja tilastotieteen laitoksen laitosneuvosto"
create_call(mat_names, 3)

tktl_inst_names = "Tietojenkäsittelytieteen laitoksen laitosneuvosto"
create_call(tktl_inst_names, 3)

biot_inst_names = "Biotieteiden laitoksen laitosneuvosto"
create_call(biot_inst_names, 4)

ymp_inst_names = "Ympäristötieteiden laitoksen laitosneuvosto"
create_call(ymp_inst_names, 3)

ope_inst_names = "Opettajankoulutuslaitoksen laitoksen laitosneuvosto"
create_call(ope_inst_names, 5)

kayt_inst_names = "Käyttäytymistieteiden laitoksen laitosneuvosto"
create_call(kayt_inst_names, 5)

sos_inst_names = "Sosiaalitieteiden laitoksen laitosneuvosto"
create_call(sos_inst_names, 5)

pol_inst_names = "Politiikan ja talouden tutkimuksen laitoksen laitosneuvosto"
create_call(pol_inst_names, 5)

el_inst_names = "Elintarvike- ja ympäristötieteiden laitoksen laitosneuvosto"
create_call(el_inst_names, 5)

agri_inst_names = "Maataloustieteiden laitoksen laitosneuvosto"
create_call(agri_inst_names, 3)

met_inst_names = "Metsätieteiden laitoksen laitosneuvosto"
create_call(met_inst_names, 4)

tal_inst_names = "Taloustieteen laitoksen laitosneuvosto"
create_call(tal_inst_names, 3)

create_call('Yliopistokollegio – Teologinen tiedekunta', 1)
create_call('Yliopistokollegio – Oikeustieteellinen tiedekunta', 1)
create_call('Yliopistokollegio – Lääketieteellinen tiedekunta', 1)
create_call('Yliopistokollegio – Humanistinen tiedekunta', 2)
create_call('Yliopistokollegio – Matemaattis-luonnontieteellinen tiedekunta', 2)
create_call('Yliopistokollegio – Farmasian tiedekunta', 1)
create_call('Yliopistokollegio – Biotieteellinen tiedekunta', 1)
create_call('Yliopistokollegio – Käyttäytymistieteellinen tiedekunta', 2)
create_call('Yliopistokollegio – Valtiotieteellinen tiedekunta', 2)
create_call('Yliopistokollegio – Maatalous-metsätieteellinen tiedekunta', 1)
create_call('Yliopistokollegio – Eläinlääketieteellinen tiedekunta', 1)
