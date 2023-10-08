
USE MvcProductStore
GO

SET IDENTITY_INSERT Brands ON
INSERT INTO Brands (BrandId, Name)
VALUES
    (1, 'New Balance'),
    (2, 'Asics'),
    (3, 'Adidas'),
    (4, 'Nike'),
    (5, 'Salomon');
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
