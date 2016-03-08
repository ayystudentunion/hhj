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
               workflow: :workflow_normal,
               organ_id: organ.id,
               date_start: Date.parse('02-12-2013'),
               date_open:  Date.parse('02-12-2013'),
               date_end:   Date.parse('10-12-2013')
              )
end

# Kollegiot

organ_description = {
  en: "
The tasks of the University Collegium include:

 * deciding on the number of members of the University Board and the duration of the Board's term of office
 * appointing members from outside the university community to the University Board
 * confirming the selections of the university community groups as the Board members
 * releasing the Board members from their positions on the recommendation of the Board
 * appointing the university auditors
 * confirming the university's financial statements and annual report, as well as deciding on granting discharge from liability to the Board members and the Rector
 * deciding on filing a suit for damages against a Board member, the Rector and the auditor
 * appointing the Chancellor
 * convening at least twice a year to discuss major issues concerning the entire university
  ",
  fi: "
Yliopistokollegion tehtävänä on:

 * päättää yliopiston hallituksen jäsenmäärästä sekä hallituksen ja sen jäsenten toimikauden pituudesta
 * valita yliopistoyhteisön ulkopuoliset jäsenet yliopiston hallitukseen
 * vahvistaa yliopistoyhteisön ryhmien valinnat hallituksen jäseniksi
 * vapauttaa hallituksen jäsen tehtävästään hallituksen esityksen perusteella
 * valita yliopiston tilintarkastajat
 * vahvistaa yliopiston tilinpäätös ja toimintakertomus sekä päättää vastuuvapauden myöntämisestä hallituksen jäsenille ja rehtorille
 * päättää vahingonkorvauskanteen nostamisesta hallituksen jäsentä, rehtoria ja tilintarkastajaa vastaan.
 * valita kansleri
 * kokoontua vähintään kaksi kertaa vuodessa keskustelemaan merkittävistä koko yliopistoa koskevista asioista
",
  sv: "
Universitetskollegiet har till uppgift att:

 * besluta om antalet medlemmar i styrelsen och om styrelsens och dess medlemmars mandattid
 * utse de utomstående medlemmarna i universitets styrelse
 * fastställa valet av de styrelsemedlemmar som utses av grupperna i universitetssamfundet
 * entlediga en styrelsemedlem från sitt uppdrag på styrelsens framställan
 * välja revisorer för universitetet
 * fastställa universitetets bokslut och verksamhetsberättelse samt besluta om beviljande av ansvarsfrihet för styrelsemedlemmar och rektorn
 * besluta om väckande av skadeståndstalan mot en styrelsemedlem, rektorn och revisor
 * välja kansler
 * sammanträda minst två gånger om året för att diskutera sådana viktiga frågor som gäller hela universitetet."

}

create_call({ fi: 'Yliopistokollegio – Teologinen tiedekunta', sv: 'Universitetskollegiet – Teologiska fakulteten',
              en: 'The University Collegium – The Faculty of Theology' }, 1, organ_description)
create_call({ fi: 'Yliopistokollegio – Oikeustieteellinen tiedekunta', sv: 'Universitetskollegiet – Juridiska fakulteten',
              en: 'The University Collegium – The Faculty of Law' }, 1, organ_description)
create_call({ fi: 'Yliopistokollegio – Lääketieteellinen tiedekunta', sv: 'Universitetskollegiet – Medicinska fakulteten',
              en: 'The University Collegium – The Faculty of Medicine' }, 1, organ_description)
create_call({ fi: 'Yliopistokollegio – Humanistinen tiedekunta', sv: 'Universitetskollegiet – Humanistika fakulteten',
              en: 'The University Collegium – The Faculty of Arts' }, 2, organ_description)
create_call({ fi: 'Yliopistokollegio – Matemaattis-luonnontieteellinen tiedekunta', sv: 'Universitetskollegiet – Matematisk-naturvetenskapliga fakulteten',
              en: 'The University Collegium – The Faculty of Science' }, 2, organ_description)
create_call({ fi: 'Yliopistokollegio – Farmasian tiedekunta', sv: 'Universitetskollegiet – Farmaceutiska fakulteten',
              en: 'The University Collegium – The Faculty of Pharmacy' }, 1, organ_description)
create_call({ fi: 'Yliopistokollegio – Biotieteellinen tiedekunta', sv: 'Universitetskollegiet – Bio- och miljövetenskapliga fakulteten',
              en: 'The University Collegium – The Faculty of Biological and Enviromental Sciences' }, 1, organ_description)
create_call({ fi: 'Yliopistokollegio – Käyttäytymistieteellinen tiedekunta', sv: 'Universitetskollegiet – Beteendevetenskapliga fakulteten',
              en: 'The University Collegium – The Faculty of Behavioural Sciences' }, 2, organ_description)
create_call({ fi: 'Yliopistokollegio – Valtiotieteellinen tiedekunta', sv: 'Universitetskollegiet – Statsvetenskapliga fakulteten',
              en: 'The University Collegium – The Faculty of Social Sciences' }, 2, organ_description)
create_call({ fi: 'Yliopistokollegio – Maatalous-metsätieteellinen tiedekunta', sv: 'Universitetskollegiet – Agrikultur-forstvetenskapliga fakulteten',
              en: 'The University Collegium – The Faculty of Agriculture and Forestry' }, 1, organ_description)
create_call({ fi: 'Yliopistokollegio – Eläinlääketieteellinen tiedekunta', sv: 'Universitetskollegiet – Veterinärmedicinska fakulteten',
              en: 'The University Collegium – The Faculty of Veterinary of Medicine' }, 1, organ_description)
