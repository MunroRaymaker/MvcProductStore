﻿
USE MvcProductStore
GO

SET IDENTITY_INSERT Brands ON
INSERT INTO Brands (BrandId, Name)
VALUES
    (1, 'New Balance'),
    (2, 'Asics'),
    (3, 'Adidas'),
    (4, 'Nike'),
    (5, 'Salomon'),
    (6, 'Hoka'), --new
    (7, 'Puma'), --new
    (8, 'Mizuno'); --new

SET IDENTITY_INSERT Brands OFF
GO

SET IDENTITY_INSERT Categories ON
INSERT INTO Categories (CategoryId, Name, Description)
VALUES
    (10, 'Mens Daily Trainers', 'A Selection of daily running shoes for the discerning user'),
    (20, 'Womens Daily Trainers', 'A Selection of daily running shoes for the discerning user'),
    (30, 'Mens Competition', 'A Selection of Competition running shoes for the discerning user'),
    (40, 'Womens Competition', 'A Selection of Competition running shoes for the discerning user'),
    (50, 'Mens Trail Running Shoes', 'A Selection of Trail running shoes for the discerning user'),
    (60, 'Womens Trail Running Shoes', 'A Selection of Trail running shoes for the discerning user');
SET IDENTITY_INSERT Categories OFF
GO


INSERT INTO Products(ProductId, ItemNumber, CategoryId, Description, Currency, Price, Name, ImageUrl, BrandId)
VALUES
    (1, '1000', 10, 'NEW BALANCE Fresh Foam X 1080 v12. If we only made one running shoe, that shoe would be the 1080. What makes the 1080 unique isn’t just that it’s the best running shoe we make, it’s also the most versatile. The 1080 delivers top-of-the-line performance to every kind of runner, whether you’re training for world-class competition, or catching a rush hour train. The Fresh Foam X 1080v12 represents a consistent progression of the model’s signature qualities. The smooth transitions of the pinnacle underfoot cushioning experience are fine-tuned with updated midsole mapping, which applies more foam to wider areas of the midsole and increases flexibility at the narrower points. The ultra-modern outlook is also reflected in the 1080’s upper construction. The v12 offers a supportive, second-skin style fit with an engineered Hypoknit upper, for a more streamlined overall design.', 'DKK', 1023.0, 'Fresh Foam X 1080 v12', '/images/products/nb_1080_12_orange.jpg', 1),
    (2, '1001', 10, 'Asics GT-2000 12 is, as the name indicates, the 12th edition of the shoe, but this time significant changes have been made to the shoes design. GT-2000 12 is still a stability shoe, but with a new 3D Guidance System™ to offer this stability. Its a more adaptive support that adjusts to your running style. The platform of the shoe itself is also wider, again to create stability. The midsole has also received an upgrade; in this version, FF Blast+ material is used, along with PureGEL™ in the heel. GT-2000 12 has an 8mm heel drop.', 'DKK', 1300.0, 'GT-2000 12', '/images/products/1011b691_400_sr_rt_glb_png_1500x1500-jpg.jpg', 2),
    (3, '1002', 20, 'New Balance Fresh Foam X Evoz v3 is a neutral running shoe with high shock absorption. The shoe is made with New Balance Fresh Foam X midsole material, as well as a heel drop of 4mm. Evoz v3 is made based on the New Balance Green Leaf Standard, which ensures that at least 50% of the materials used are recycled. The upper part is made of a breathable mesh in a seamless design.', 'DKK', 727.0, 'Fresh Foam Evoz v3', '/images/products/new_balance_evoz_v3_white_womens.jpg', 1),
    (4, '1003', 20, 'Asics Noosa Tri 15 does exactly what its predecessors do, it stands out from the crowd. With its unique design, this shoe has its own loyal audience. Noosa Tri 15 is a lightweight, dynamic running shoe that, in this 15th edition, features a higher midsole made of the excellent FF Blast™ midsole material. The upper part is deliberately kept light and highly breathable to perform well in hot weather conditions and over longer periods of time. Noosa Tri 15, like its predecessor, has the "rocker geometry" in the midsole, which means you get a rolling toe-off when you run.', 'DKK', 938.0, 'Gel-Noosa Tri 15', '/images/products/1012b429_400_sr_rt_glb_png_1500x1500-jpg.jpg', 2),
    (5, '1004', 30, 'ADIDAS Adizero Adios Pro 3. The adidas Adizero Adios Pro 3 is the ultimate long-distance running shoe, designed for fast runners who want to improve their performance and set new records. The shoes midsole consists of two layers of durable Lightstrike Pro foam that provide efficient shock absorption. The ADIZERO ADIOS PRO 3 also features ENERGYRODS 2.0 in the midsole, optimized to give runners the perfect combination of stiffness and energy return. The upper is made of lightweight, thin materials to keep the weight down and offer the necessary breathability when the pace is increased. The outsole is made of Continental Rubber, ensuring excellent traction and helping to handle sharp turns at high speeds.', 'DKK', 1882.0, 'Adizero Adios Pro 3', '/images/products/id8473_1_footwear_photography_side_lateral_center_view_white.jpg', 3),
    (6, '1005', 40, 'ADIDAS Adizero Boston 10. The Adidas Boston 10 is the latest generation of Adidas’ incredibly popular Boston series. It is a complete overhaul of the last generation, where almost everything on the shoe has been improved. But the shoe is still true to its predecessor, so you get a fast shoe with enough shock-absorption to keep you running for miles. The shoe should be perceived as a younger sibling to Adidas’ high-end model. The Adidas Boston 10 can be used for both work-out and race-day.', 'DKK', 750.0, 'Adizero Boston 10', '/images/products/boston_10_8_.jpg', 3),
    (7, '1006', 50, 'NIKE Pegasus Trail 3. Nike Pegasus Trail 3 has the padded comfort as in the previous version, but this time it comes with a design more similar to the classic Pegasus-shoe. In addition it is designed with great traction which makes it specially suited for rocky terrain while increased support around the midfoot ensures a safer running experience. ', 'DKK', 620.0, 'Pegasus Trail 3', '/images/products/trail-3-4.jpg', 4),
    (8, '1007', 60, 'SALOMON Pulsar Trail Pro. The Salomon Pulsar Trail Pro is a fast trail shoe with the latest technologies. Salomon has developed this dynamic trail running shoe with some of the worlds best athletes to focus on what really matters when you trail run: Weight, grip and the combination of shock absorption and feel with the surface. In the Pulsar Trail Pro, you get Salomons Energy Surge foam, which is fast, durable and comfortable. In addition to the foam, you also get an Energy Blade that helps give you momentum so you can run as fast as possible, no matter how far you run. The upper part is made of a breathable mesh material and with reinforcements in the most exposed places. The outsole has Salomons Contagrip, so you can get a good grip on the ground, even around the fast turns.', 'DKK', 708.0, 'Pulsar Trail Pro', '/images/products/salomon_pulsar_trail_pro_wine_4_.jpg', 5);

GO

-- new
INSERT INTO Products(ProductId, ItemNumber, CategoryId, BrandId, Currency, Price, Name, ImageUrl, Description)
VALUES
    (9,  '1008', 10, 6, 'DKK', 1499.0, 'Hoka Clifton 9', '/images/products/hoka_clifton_9_gtx_dbes.jpg', ' Hoka Clifton 9 er en let og støddæmpende mængdetræningssko fra Hoka. Denne sko henvender sig til dig som søger en alsidig sko til både dine korte og længere ture. Clifton 9 leverer den perfekte kombination af en let vægt og suveræn støddæmpning og netop derfor er den en favorit hos mange.'),
    (10, '1010', 10, 6, 'DKK', 1599.0, 'Hoka Bondi 8', '/images/products/1500x1500_hokabm1.jpg', ' Hoka One One Bondi 8 er den oprindelige konge af de allermest komfortable løbesko. Det var Hoka One One, der med introduktionen af Bondi sørgede for, at de fleste andre sko brands har fuldt trop og nu laver løbesko med masser af skum og bløde mellemsåler. I denne 8. udgave af Bondi er Hoka tro mod rødderne i Bondi-serien og har lavet en sko med enormt meget stødabsorbering. Det er det klassiske CMEVA skum, som Hoka plejer at benytte. Denne gang er den dog lettere og blødere. Desuden er hælen blevet forlænget, så skoen er mere stabil. Hvis du har elsket tidligere udgaver af Bondi, vil du også være vild med denne.'),
    (11, '1011', 10, 3, 'DKK', 1399.0, 'Adidas Solarboost 5', '/images/products/ie6787_1_footwear_photography_side_lateral_center_view_white.jpg', 'adidas Solar Boost 5 er en komfortabel og støttende mængdetræningssko. Solar Boost 5 er lavet med det nye LIGHT BOOST mellemsåls materiale der er 32% lettere og 3% mere energireturnerende end det oprindelige BOOST materiale. EVA control platformen guider dine fødder, og giver stabilitet i hvert skridt. Solar Boost 5 er en del af adidas Primegreen serie, som er en række produkter produceret på en bæredygtig facon. Overdelen er produceret med mindst 50% genanvendte materialer, hvilket hjælper til at reducere plastikaffald. Derudover giver mesh materialet god ventilering. På ydersålen finder du en continental gummi belægning, der har ry for at være en af de mest holdbare på markedet.'),
    (12, '1012', 10, 2, 'DKK', 914.0, 'Asics Gel-Cumulus 25 TR', '/images/products/', ' Asics Gel-Cumulus 25 TR er en alsidig mængdetræningssko til dig, der gerne vil have en responsiv og komfortabel løbesko, som du kan bruge til træning til alle distancer. Gel-Cumulus 25 har fået flere væsentlige ændringer i forhold til Gel-Cumulus 24. Den har fået et nyt mellemsålsmateriale (FF Blast+), der er blødere og mere responsivt end det materiale, der blev brugt tidligere. Og samtidig er Asics Gel-Cumulus 25 blevet mere fleksibel. Overdelen er lavet i et luksuriøst Jacquard mesh-materiale, der smyger sig om foden og gør det behageligt, samtidig med at det sørger for fremragende åndbarhed. Ydersålen på denne TR udgave er en anelse mere grov end på den normale, hvilket gør skoen mere anvendelig i terræn.'),
    (13, '1013', 10, 5, 'DKK', 967.0, 'Salomon DRX Bliss', '/images/products/l47291700_0_gho_drx_blissdesert_sage_zinna_white1.jpg', ' Salomon DRX Bliss er iblandt en af Salomons række af nye landevejssko. Salomon DRX Bliss er til dig der ønsker en let og komfortabel løbesko, men samtidig også har brug for lidt ekstra stabilitet. Stabiliteten kommer fra en Active Chassis™, der er et lag af et fastere mellemsåls materiale der guider foden mod en mere stabil landing. Hældroppet på DRX Bliss er 8mm. Overdelen er lavet i et åndbart Engineered Mesh der føles blød, men hælkappen er mere fast dog uden at være alt for grov.'),
    (14, '1014', 10, 1, 'DKK', 1400.0, 'New Balance Fresh Foam X Vongo v6', '/images/products/nb_mvngolg6_1_.jpg', ' New Balance Vongo v6 er en innovativ løbesko, med stabiliserende elementer. Vongo v6 har fået en betydelig opdatering fra den tidligere udgave. Mellemsålen er nu lavet af et to-lags Fresh Foam X materiale, hvor den øverste halvdel er blødere end den nederste. Hældroppet er 6mm. Vongo v6 har også fået en mere udtalt rocker-geometri. Vongo v6 har en EVA ”plade”, der hjælper med at skabe en mere dynamisk stabilitet. '),
    (15, '1015', 10, 3, 'DKK', 2241.0, 'Adidas Adizero Prime X 2 Strung', '/images/products/adidas_adizero_prime_x_2_strung.jpg', ' adidas Prime X 2 Strung er med sit unikke udseende en sko der er svær at tage øjnene fra. Prime X 2 Strung er adidas svar på en ultimative træningssko. Med en stackheight på hele 50mm, lavet i det ultrabløde Lightstrike Pro materiale, så får du her en sko med det ultimative bounce og beskyttelse mod underlaget. I mellemsålen finder du ligeledes 2 carbon plader, der gør løbeoplevelsen endnu mere dynamisk. Overdelen er lavet i dette ”strung”-materiale. Strung er en form flettet materiale – hvilket giver en fleksibel pasform, men flettet stærkest i området omkring hæl og midtfod for at skabe stabilitet. Ydersålen er lavet af Continental™ gummi, som set på mange af adidas andre løbesko.'),
    (16, '1016', 10, 7, 'DKK', 812.0, 'Puma Magnify Nitro 2', '/images/products/puma_magnify_nitro_2_fire_orchid_blue.jpg', ' Med Puma Magnify Nitro 2 får du Pumas med komfortable løbesko. Med en stack-height på hele 40mm i hælen, og 30mm i forfoden, lavet i det ultra støddæmpende Nitro™ mellemsåls materiale, så får du maksimal beskyttelse af underlaget. Magnify Nitro 2 er en neutral mængdetræningssko, med et 10mm hældrop, ideel til brug på længere trænings ture, eller på dage hvor du ønsker at give din krop mest mulig komfort. Overdelen er lavet i et knit, der er fleksibelt og åndbart. Ydersålen er lavet med Pumagrip, som set på mange af Pumas andre sko, et materiale der er garant for noget af det mest grippy på markedet.'),
    (17, '1017', 10, 2, 'DKK', 1280.0, 'Asics Gel-Kayano 30', '/images/products/1011b548_800_sr_rt_glb_png_1500x1500-jpg.jpg', ' Asics Kayano 30 er landet, og lad os med det samme slå fast, stabilitet har aldrig føltes bedre. Som med Asics Nimbus 25 har Asics Kayano 30 også fået en gedigen design opdatering. Med Kayano 30 er det indført et nyt stabilitetssystem ved navn 4D Guidance System™, der bidrager med en mere naturlig pronations støtte. Herudover skiftes det klassiske GEL ud med PureGEL™ der er blødere end den tidligere udgave. Mellemsålen er blevet højere, og det er den ved hjælp af 20% ekstra af det fremragende FF Blast+ skummateriale. Overdelen er kompakt, stabil og med masser af komfort. '),
    (18, '1018', 10, 4, 'DKK', 652.0, 'Nike Air Zoom Pegasus 38 FlyEase', '/images/products/dj5404-100-phsrh000.jpg', 'Så er den nyeste model af Nikes mest populære løbesko, Pegasus, landet. I den nye Pegasus 38 har de holdt fast i mange af de ting, der virkede fremragende i den forrige udgave, men der er også blevet plads til flere forbedringer. Nike Pegasus 38 er den perfekte allround sko, hvis du gerne vil have en komfortabel sko, der kan bruges til alle slags ture. Nike har i denne nyeste udgave af Pegasus holdt fast i den velkendte kombination af Zoom Air i forfoden og React-skum i mellemsålen fra den forrige udgave og lavet de store ændringer og forbedringerne i overdelen. Der er blandt andet blevet mere plads i forfoden, meshen har fået et nyt design for at forbedre åndbarheden, pløsen har fået en lille pude for at øge komforten, og hælkappen er ændret, så skoen sidder endnu bedre fast på foden.'),
    (19, '1019', 20, 6, 'DKK', 1200.0,'Hoka Kawana','hoka_kawana_ncif.jpg','Hoka One One Kawana er en den første af sin slags fra Hoka. Det er en mængdetræningssko til dig, der godt kan lide den traditionelle Hoka-følelse, Men gerne vil have en mere fast stødabsorbering. Mellemsålen på Hoka Kawana er lavet af CMEVA-skum, der giver førsteklasses støddæmpning, men uden, at du føler, at du synker helt ned i skoene. Bagerst på skoen har Hoka puttet deres SwallowTail teknologi i. Det betyder, at hælen stikker lidt længere ud i den ene side, hvilket giver dig en mere stabil løbetur, hvor du hele tiden føler, at du lander behageligt og sikkert. Overdelen er et let meshmateriale, der er super åndbart og følger foden, desuden er der blevet gjort ekstra plads til akillessenen. Derudover får du den klassiske Hoka-rocker, der skubber dig fremad. '),
    (20, '1020', 20, 8, 'DKK', 920.0,'Mizuno Wave Neo Ultra','mizuno_wave_neo_ultra_womens_4_.jpg','Mizuno Wave Neo Ultra er en moderne mængdetræningssko fra Mizuno. Den er lavet med fuldt enerzy-skum i mellemsålen, der giver en superblød og bouncy fodafvikling, så du cruise afsted med en blød fornemmelse. Overdelen på Mizuno Wave Neo Ultra er lavet i et strikket materiale, der krammer foden, er åndbart og ventilerende, samtidig med, at det yder rigtig god støtte og holder den godt fast. Desuden er overdelen lavet miljøvenligt uden indfarvning. '),
    (21, '1021', 20, 7, 'DKK', 1200.0,'Puma Magnify Nitro 2','puma_magnify_nitro_2_icy_blue_wmn.jpg','Med Puma Magnify Nitro 2 får du Pumas med komfortable løbesko. Med en stack-height på hele 40mm i hælen, og 30mm i forfoden, lavet i det ultra støddæmpende Nitro™ mellemsåls materiale, så får du maksimal beskyttelse af underlaget. Magnify Nitro 2 er en neutral mængdetræningssko, med et 10mm hældrop, ideel til brug på længere trænings ture, eller på dage hvor du ønsker at give din krop mest mulig komfort. Overdelen er lavet i et knit, der er fleksibelt og åndbart. Ydersålen er lavet med Pumagrip, som set på mange af Pumas andre sko, et materiale der er garant for noget af det mest grippy på markedet.'),
    (22, '1022', 20, 1, 'DKK', 1490.0,'FuelCell SuperComp Trainer V2','new_balance_fuelcell_supercomp_trainer_v2_orange_5_.jpg','New Balance FuelCell SuperComp Trainer v2 er din go-to løbesko, hvis du ikke vil gå på kompromis med komfort under fødderne. I denne 2’ udgave af FuelCell SuperComp Trainer har New Balance sænket stackheighten (mellemsålen), men holdt komforten oppe ved at benytte et endnu blødere FuelCell materiale end tidligere. FuelCell SuperComp Trainer v2 er den perfekte sko når du bare skal cruise derudaf, med en blød landing og et effektivt afsæt takket være skoens Energy Arc (carbon-plade). '),
    (23, '1023', 20, 1, 'DKK', 1199.0,'Fresh Foam X More v4','new_balance_fresh_foam_more_v4_blue_purple.jpg','New Balance Fresh Foam More V4 er New Balances blødeste Fresh Foam sko til dato. Med hele 34 MM af New Balances Fresh Foam X skum, er hårde underlag ikke længere et problem. Trods den store mængde skum er skoen relativt let og fleksibel, hvilket gør den til en oplagt mængdetræningssko. Ydersålen er også blevet lavet ekstra bred, skoen stadig føles stabil, på trods af den bløde mellemsål. New Balance har også formået endnu engang at lave en super fleksibel og åndbar overdel, der sidder behageligt på både smalle og brede fødder.'),
    (24, '1024', 20, 1, 'DKK', 1599.0,'Fresh Foam X 1080 v12','new_balance_1080_12_light_blue_womens_4_.jpg','1080 er New Balances førsteklasses performance-orienterede løbesko til daglig træning. Denne sko er fyldt med blød og komfortabel Fresh Foam X mellemsålsmateriale for at give dig en suverænt god støddæmpning samt en Hypoknit-overdel som er designet til at veje mindst muligt og give størst mulig åndbarhed. Denne udgave, V12, er den 12. version af 1080. Der er lavet opdateringer på skoen, så mellemsålen er blevet fintunet til at give en endnu mere behagelig tur end tidligere. Derudover er ydersålen ændret, så den giver bedre greb end tidligere. Dette er en sko som giver en god komfortabel tur hver eneste gang.'),
    (25, '1025', 20, 8, 'DKK', 950.0,'Wave Rider 27','mizuno_wave_rider_27_orangewhite.jpg','Mizuno Wave Rider 27 er en klassiker i løbebranchen og er blandt markedets allermest populære neutrale løbesko. Wave Rider er kendt for det bløde rul hen igennem skridtafviklingen, samt det meget responsive afsæt. Alt i alt er Mizuno Wave Rider en klassiker, der nu er blevet forbedret med nye teknologier i Mizuno Wave Rider 27. Mizuno Wave Rider 27 fortsætter med det populære Enerzy mellemsåls-materiale der er blødt og responsivt, men det er overdelen på denne sko der for alvor har fået et løft. På Wave Rider 27 finder du en opdateret Jacquard Mesh overdel der er både fleksibelt og åndbart, så den passer til netop din fod. '),
    (26, '1026', 20, 5, 'DKK', 880.0,'Aero Glide','salomon_aero_glide_womens_safari_5_.jpg','Salomon Aero Glide er efterfølgeren til den populære Salomon Glide Max. Skoen er opbygget med en stor portion Energy Foam i mellemsålen, hvilket giver en blød og responsiv fornemmelse i dit løb. Energy Foam er Salomons meget støddæmpende materiale, så du kan få mest mulig komfort. På ydersålen er der Contagrip, hvilket giver dig et fremragende greb på både landevej - både tørre og våde - og grusstier. Overdelen er lavet i et slidstærkt mesh-materiale, der lader din fod ånde, men som også holder din fod godt på plads. '),
    (27, '1027', 30, 1, 'DKK', 1200.0,'FuelCell Rebel V3','nb-fuelcell-rebel-v3.jpg','New Balance FuelCell Rebel v3 er en hurtig løbesko til dine konkurrencer eller interval-/ tempoture. Skoen er bygget op med en blød og responsiv FuelCell mellemsål, der både tager stødene fra underlaget, men samtidig sender dig afsted med høj returenergi. New Balance FuelCell Rebel v3 er en meget let sko, hvilket gør, at du nemt kan løbe med høj kadance og sætte fart på. Overdelen er lavet i et tyndt mesh-materiale, der er meget åndbart, men også holder foden godt på plads. På ydersålen ligger der gummi under forfoden og og hælen, hvilket giver et godt greb, og holdbarhed, men samtidig holder det også vægten nede, at det ikke er under hele foden. '),
    (28, '1028', 30, 1, 'DKK', 1599.0,'FuelCell SuperComp Elite v3','supercomp_elite_v3_purple_1.jpg','New Balance Fuelcell Elite V3 er New Balances hurtigste konkurrencesko. New Balance FuelCell Elite V3 er pakket med flere af de fedeste teknologier fra New Balance. Du får FuelCell-skum i mellemsålen, der i kombination med EnergyArc-carbonpladen giver en virkelig fremdrift og responsivitet, som samtidig er blød og komfortabel. New Balance FuelCell Elite V3 er en af de mest komfortable supersko, der findes. I forhold til den tidligere version har New Balance gentænkt skoen. EnergyArc giver dig en trampolinlignende effekt, når du løber og der er en ny overdel i et sokkelignende design, der er lettere og luftigere. '),
    (29, '1029', 30, 2, 'DKK', 1499.0,'Magic Speed 3','1011b703_100_sr_rt_glb_png_1500x1500-jpg.jpg',' Asics Magic Speed 3 er Asics bud på en hurtig sko til interval/tempotræning eller konkurrence. Den har fået en del opdateringer i forhold til den andet udgave af Asics Magic Speed, blandt andet er skummet blevet et andet, så du nu udelukkende får Asics topskum, FF Blast+ i to lag i  mellemsålen. Derudover får du en fuld carbonplade i mellemsålen, der giver skoen stivhed og stabilitet. Asics Magic Speed 3 er stadig lavet til at skulle kunne holde i flere kilometer end de typiske carbon-racesko. Derfor er det en oplagt træningssko til dine hurtige træninger, eller en oplagt konkurrencesko, hvis du vil have noget blødt og hurtigt, der kan holde i mange kilometer. Asics Magic Speed 3 er en super hurtig løbesko, med carbonplade i mellemsålen, der giver et push fremad i hvert skidt, så du får den optimale effekt i dit løb.'),
    (30, '1030', 30, 6, 'DKK', 1399.0,'Mach X','hoka_mach_x_mens_green_6_.jpg','Hoka Mach X'),
    (31, '1031', 30, 8, 'DKK', 1299.0,'Wave Duel Pro','mizuno_wave_duel_pro_unisex_red_blue.jpg','Mizuno Wave Duel Pro er en innovativ race sko fra Mizuno. Med en karakteristisk mellemsål, lavet af det utroligt bouncy og lette mellemsåls materiale Enerzy Lite, så får du med Wave Duel Pro en sko der vil have dig frem på fødderne, og vil have dig fremad. Overdelen er enkel, let og lavet i et tynd materiale med høj åndbarhed. Mellemsålen er lavet med en aggressiv rocker geometri, som Mizuno kalder en Smooth Speed Assist teknologi. For at opnå den maksimale energi returnering, samt tilføje en smule stabilitet, ligger der i mellemsålen også en carbon-plade placeret.  '),
    (32, '1032', 30, 2, 'DKK', 989.0,'Novablast 2','novablast-2-asics-herre-1.jpg','ASICS Novablast 2 kommer denne gang med en endnu mere smooth og lydhør fornemmelse end den forrige version. Dette skyldes ikke mindst at FF BLAST-dæmpningen har givet skoen en blødere landing og et mere energisk rebound. På samme tid er hælen designet til at give en bedre skridtafvikling.'),
    (33, '1033', 40, 7, 'DKK', 900.0,'Deviate Nitro 2 WTRepel','puma_deviate_nitro_2_wtrepel_black_purple_5_.jpg','Puma Deviate Nitro 2 er en enormt alsidig og hurtig mængdetræningssko fra Puma. Du får Pumas spændstige Nitro Elite skum i mellemsålen, der giver en blød og fjedrende løbeoplevelse, sammen med det almindelige Nitro skum, gør det, at du får en holdbar og sjov sko. Derudover er der en carbonplade i sålen, der giver endnu mere spændstighed, samtidig med at det giver skoen noget stabilitet. Ydersålen er belagt med Puma Grip, der giver et rigtig godt greb og høj holdbarhed. Overdelen er lavet i mesh, der giver åndbarhed, derudover er der PWRTAPE, som sørger for, at din fod bliver holdt på plads og giver stabilitet. Denne udgave er en WTR udgave, der betyder at overdelen er lavet med i et vandafvisende materiale. '),
    (34, '1034', 40, 1, 'DKK', 1050.0,'FuelCell SuperComp Elite v3','new_balance_fuelcell_supercomp_racer_v3_womens_green_white_5_.jpg','New Balance Fuelcell Elite V3 er New Balances hurtigste konkurrencesko. New Balance FuelCell Elite V3 er pakket med flere af de fedeste teknologier fra New Balance. Du får FuelCell-skum i mellemsålen, der i kombination med EnergyArc-carbonpladen giver en virkelig fremdrift og responsivitet, som samtidig er blød og komfortabel. New Balance FuelCell Elite V3 er en af de mest komfortable supersko, der findes. I forhold til den tidligere version har New Balance gentænkt skoen. EnergyArc giver dig en trampolinlignende effekt, når du løber og der er en ny overdel i et sokkelignende design, der er lettere og luftigere. '),
    (35, '1035', 40, 3, 'DKK', 2300.0,'Adizero Takumi Sen 9','id6939_1_footwear_photography_side_lateral_center_view_white.jpg','adidas adizero Takumi Sen 9 er en let og dynamisk racesko. Takumi Sen 9 har stadig denne tætte og kompakte pasform, der er ideel til race-day. Der er tilføjet lidt ekstra padding omkring hælen for ekstra komfort. Mellemsålen i Takumi Sen 9 er lavet af Lightstrike Pro, der er adidas hurtigeste, mest energi returende mellemsåls materiale. Med adidas EnergyRods får du hjælp til en hurtig fodafvikling, når du sætter afsted på jagten mod en ny personlig rekord. '),
    (36, '1036', 40, 2, 'DKK', 2000.0,'Novablast 3 Color Injection','1012b612_400_sr_rt_glb_png_1500x1500-jpg.jpg','Asics Novablast 3 kommer denne gang med en endnu mere bouncy og blød fornemmelse. Skoene har fået Asics FF Blast+ skum, der er blødere, mere responsivt og lettere end det FlyteFoam Blast skum, der blev brugt i den tidligere udgave af Novablast. Derfor har Asics også kunnet putte endnu mere skum i mellemsålen end tidligere, så du får en utrolig bouncy og blød fornemmelse. '),
    (37, '1037', 40, 6, 'DKK', 1200.0,'Rocket X 2','hoka_rocket_x2_bkml.jpg','Hoka Rocket X2 er Hoka’s nyeste skud på stammen indenfor konkurrence sko. Rocket X2 er en komplet ændring af den forrige udgave, med opdateringer stort set alle dele af skoen. Med Hoka Rocket X2 får du en racesko til alle distancer. Med skoens lave vægt, høje energireturnering, takket være PROFLYX™ (PEBA) mellemsålen og carbon-plade er du perfekt dækket ind til dit race. Overdelen er lavet i et tyndt åndbart mesh materiale. Samme tynde materiale finder du i pløsen der ligeledes er minimalisk for at holde vægten nede, dog uden at gå på kompromis med fastlåsningen eller stabiliteten. Mellemsålen er lavet med det spritnye PROFLYX™ (PEBA) mellemsåls-materiale, der er bouncy og energireturende. Mellemsålen har Hoka’s kendetegnede Meta-rocker geometri, der giver en god fornemmelse af et rullende løb. Carbon-pladen er prikken over i’et i en mellemsål hvor de enkelte elementer arbejder perfekt sammen. Carbon-pladen er med til at give den sidste lille energi returnering når du sætter i fart. På ydersålen vil du finde Hoka’s zonal gummi belægning. Det er et slidstærkt materiale, der udover at forlænge levetiden på dine sko, også giver et bedre greb på de dage hvor underlaget kan være en udfordring.'),
    (38, '1038', 50, 6, 'DKK', 900.0,'Speedgoat 5','1500x1500_-_2022-05-11t141451.jpg','Hoka One One Speedgoat 5 har fået en fuldstændig opgradering fra Speedgoat 4. Skoen er ændret fra sål til snørebånd. Skoene er lagt an på, at skulle være den trailsko fra Hoka med mest greb. Du får masser af komfort og greb, når du køber en Speedgoat 5. Mellemsålen har fået ændret sit design, så den er blødere men også responsiv, så du får den perfekte blanding til dien ture. Den er stadig proppet med Hokas velkendte skum, og du får det velkendte lave drop på fire mm. Overdelen er lavet i et dobbelt lag jacquard mesh, sm kan udvide sig, hvis din fod hæver under din løbetur. Desuden er Speedgoat 5 blevet 15 gram lettere end den tidligere udgave. '),
    (39, '1039', 50, 1, 'DKK', 1150.0,'Fresh Foam More Trail v3','nb_fresh_foam_more_v3_white_green_mens.jpg','New Balance Fresh Foam X Trail More v3, er New Balances blødeste Fresh Foam sko til dato. Med hele 34 MM af New Balances Fresh Foam X skum, er hårde underlag ikke længere et problem. Trods den store mængde skum er skoen relativt let og fleksibel, hvilket gør den til en oplagt mængdetræningssko. Skoen har en bred platform, så skoen stadig føles stabil, på trods af den bløde mellemsål. New Balance har også formået endnu engang at lave en super fleksibel og åndbar overdel, der sidder behageligt på både smalle og brede fødder. På denne trail udgave af Fresh Foam More, er ydersålen lavet med Vibram® gummi, der er garant for et slidstærkt og holdbart materiale. '),
    (40, '1040', 50, 3, 'DKK', 670.0,'Terrex Soulstride Flow','hp5565_1_footwear_photography_side_lateral_center_view_white.jpg','adidas Terrex Soulstride Flow er en maksimalist trail løbesko fra mærket adidas. Terrex Soulstride Flow er lavet med en klassisk snørelukning, et 8mm hældrop samt en repetitor mellemsål som du kender fra fx adidas Adistar landevejsskoen. Ydersålen er lavet af Continental™ Rubber, der har haft stor succes på en lang række af adidas sko. Overdelen er slidstærk og holdbar, men der på området ved hælen er sørget for lidt ekstra komfort med ekstra padding.'),
    (41, '1041', 50, 1, 'DKK', 1100.0,'FuelCell Summit Unknown v4','new_balance_summit_unknown_4_yellow_4_.jpg','New Balance FuelCell Summit Unknown v4 er en trail-løbesko produceret ud fra New Balance Green leaf standarder, der indebærer at minimum 50% af materialet i skoens overdel er genanvendt. I skoens mellemsål finder du FuelCell materiale der giver komfort, men uden at blive så blødt, at det føles ustabilt på dine trail løbeture. For at beskytte mod sten, skarpe genstande, grene osv. Finder du en ”Rock Stop Plate” i mellemsålen. Ydersålen er lavet i et stærkt Hydrohesion gummi, der sikrer et godt greb selv på våde overflader.'),
    (42, '1042', 50, 5, 'DKK', 979.0,'Thundercross GTX','salomon_thundercross_gtx_flintstone.jpg','Salomon Thundercross GTX er en neutral, alsidig trail løbesko. Thundercross er testet, og skabt til alle typer terræn. Skoen er skabt med et 4mm hældrop, samt 5mm dubber under sålen, i et groft mønster der kan tackle selv de mest udfordrende ruter. Mellemsålen er lavet af Salomons Energy Foam™. Overdelen på denne udgave er lavet med en vandtæt Gore-Tex membran.'),
    (43, '1043', 60, 1, 'DKK', 600.0,'Fresh Foam More Trail v3','nb_fresh_foam_more_v3_white_grey.jpg','New Balance Fresh Foam X Trail More v3, er New Balances blødeste Fresh Foam sko til dato. Med hele 34 MM af New Balances Fresh Foam X skum, er hårde underlag ikke længere et problem. Trods den store mængde skum er skoen relativt let og fleksibel, hvilket gør den til en oplagt mængdetræningssko. Skoen har en bred platform, så skoen stadig føles stabil, på trods af den bløde mellemsål. New Balance har også formået endnu engang at lave en super fleksibel og åndbar overdel, der sidder behageligt på både smalle og brede fødder. På denne trail udgave af Fresh Foam More, er ydersålen lavet med Vibram® gummi, der er garant for et slidstærkt og holdbart materiale. '),
    (44, '1044', 60, 7, 'DKK', 400.0,'Voyage Nitro 3 GTX','puma_voyage_nitro_3_gtx_wmns_black_neon_sun.jpg','Puma Voyage NITRO 3 GTX er skabt til at erobre enhver type terræn med lethed og komfort. Med den avancerede NITRO™ skummellemsål er du sikret Pumas letteste og mest responsive løbeoplevelse. PUMAGRIP ATR ydersålen er designet til at give maksimal trækkraft på is, mudder og ujævne overflader. På denne udgave af Voyage Nitro 3 GTX får du en vandtæt Gore-Tex membran i overdelen. Uanset årstiden kan du roligt tage Puma Voyage Nitro 3 GTX med på din løbetur.'),
    (45, '1045', 60, 1, 'DKK', 700.0,'Fresh Foam X Hierro V7','new_balance_hierro_7_orange_womens_4_.jpg',' New Balance Fresh Foam Hierro V7 er designet med Fresh Foam X-mellemsål for at tilbyde dig en blød og responsiv fornemmelse, en MegaGrip-ydersål for øget greb i underlag samt en åndbar meshoverdel med fibre i for at give dig øget beskyttelse mod slag. Derudover er denne version gjort lettere og mere agil end de tidligere versioner af skoen. En god sko til dig som ønsker en trailsko, der fungerer på forskellige underlag - og også kan bruges på asfaltstykker på vej mod skoven. Skoen har desuden fået New Balance Green Leaf mærket, hvilket betyder at flere dele af skoen er lavet af genanvendte materialer - blandt andet mindst 50% af overdelen og 3% af mellemsålen.')


    
GO

 INSERT INTO [dbo].[CreditCards]
        ([CardNumber]
        ,[ExpDate]
        ,[CVC]
        ,[CardholderName]
        ,[Amount]
        ,[Currency]
        ,[TransactionId]
        ,[OrderId]
        ,[PaymentStatus]
        ,[CreatedDate])
    VALUES
        ('4925000000000004'
        ,'0624'
        ,'123'
        ,'Munro Raymaker'
        ,1080
        ,'DKK'
        ,'C842A8CDEC794F2587D4634CC1EF43FC'
        ,'5yepsp'
        ,'AuthorizationApproved'
        ,GETDATE())
GO
