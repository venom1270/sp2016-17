DECLARE @CurrentMigration [nvarchar](max)

IF object_id('[dbo].[__MigrationHistory]') IS NOT NULL
    SELECT @CurrentMigration =
        (SELECT TOP (1) 
        [Project1].[MigrationId] AS [MigrationId]
        FROM ( SELECT 
        [Extent1].[MigrationId] AS [MigrationId]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
        WHERE [Extent1].[ContextKey] = N'Phase2.Migrations.Configuration'
        )  AS [Project1]
        ORDER BY [Project1].[MigrationId] DESC)

IF @CurrentMigration IS NULL
    SET @CurrentMigration = '0'

IF @CurrentMigration < '201612172201297_Initial'
BEGIN
    CREATE TABLE [dbo].[Posts] (
        [PostId] [int] NOT NULL IDENTITY,
        [Title] [nvarchar](max) NOT NULL,
        [Content] [nvarchar](max) NOT NULL,
        [Upvotes] [int] NOT NULL,
        [CreationDate] [datetime] NOT NULL,
        [User_UserId] [int],
        CONSTRAINT [PK_dbo.Posts] PRIMARY KEY ([PostId])
    )
    CREATE INDEX [IX_User_UserId] ON [dbo].[Posts]([User_UserId])
    CREATE TABLE [dbo].[Users] (
        [UserId] [int] NOT NULL IDENTITY,
        [Username] [nvarchar](max) NOT NULL,
        [Password] [nvarchar](max) NOT NULL,
        [Salt] [nvarchar](max),
        [Email] [nvarchar](max) NOT NULL,
        [RegistrationDate] [datetime] NOT NULL,
        CONSTRAINT [PK_dbo.Users] PRIMARY KEY ([UserId])
    )
    ALTER TABLE [dbo].[Posts] ADD CONSTRAINT [FK_dbo.Posts_dbo.Users_User_UserId] FOREIGN KEY ([User_UserId]) REFERENCES [dbo].[Users] ([UserId])
    CREATE TABLE [dbo].[__MigrationHistory] (
        [MigrationId] [nvarchar](150) NOT NULL,
        [ContextKey] [nvarchar](300) NOT NULL,
        [Model] [varbinary](max) NOT NULL,
        [ProductVersion] [nvarchar](32) NOT NULL,
        CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
    )
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201612172201297_Initial', N'Phase2.Migrations.Configuration',  0x1F8B0800000000000400CD59CD6EE33610BE17E83B083AB545D672B29736B077B1F52685D1CD0FA2ECA2B78091C60E518A54492A6BA3E893F5D047EA2B74A81F5AA2245BCE6FE18B4DCD7C9C197E331C8DFFFDFB9FC9FB55C2BC7B908A0A3EF50F4763DF031E8998F2E5D4CFF4E2CD8FFEFB77DF7E3339899395F7A5927B6BE45093ABA97FA7757A1C042ABA8384A8514223299458E851249280C422381A8F7F0A0E0F0340081FB13C6F7295714D13C87FE0CF99E011A43A23EC4CC4C054B98E4FC21CD53B2709A8944430F52FEF8882A35121383A411CBD3E239C2C41FADE0746099A14025BF81EE15C68A2D1E0E3CF0A422D055F86292E1076BD4E01E5168429281D39DE880FF5697C647C0A368A155494292D923D010FDF96410A5CF50785DAB741C4301661325EE7A1C4280AA57DCFDDE878C6A41172A36CA40FBC62EDC0B200C9623E07DE2C633A9330E5906949184A66B78C46BFC2FA5AFC0E7CCA33C6EAE6A041F8ACB1804B9752A420F5FA0A163523E7B1EF054DDDC055B6AA8E5EE1CA9CEBB747BE778E46905B06F6D46B6E875A48F8053848A221BE245A83C4439BC790C7AD6581B3DF35D50CAAED9067983BBE7746569F802FF5DDD4C7AFBE774A5710572BA5099F39C55443252D33E83071FBB698351A0D7CF98D3FA7F74283DA15E01DD64BC883FF11435E2199EFD7581776839D937BBACCF55DDB94A90357C0F287EA8EA6453918990737861968F7A914C99560A578B17A734DE4124C3445EB5128321939464C824D526D4DB5C2A2A1A966A45F21D5CCB60F49B54AEFA552CDECC749F20AD9764994FA2A64FCF23B87843D45926FDFE4242194BDBC6F57B0A40A99FC0C95A0CCF58794822ADF3B4A4155258694820F4A8988E6BBD7E85BEEDCF4E284C75EBF19C5A154A6E3B96015A029E63D6E3AF5C7A3D1612B2C9D80B6C46D008B46A009F883EB5ECD9176A933D710A198D01593F2553C409297B48ED2871695D54F95B4716D370821E8E6496E82DCB0BDE57853D9B8DFA55C44D251AE39DA44A8E852136893C92DB35B0FD5DA694D0C06E9576758D32F6D736B77D3990EBEDA93DBF4DB41D170578D79D0D3994FCE489A6289A875EAE58A17166DFAEC4DB87FDB9A141841A43ABA576BADDD09AF126CFB9DA7A62F8AE1944AA50D076F89A919B3386989B93CEDA151B55B9D8AED83AAC855499BEFA546FFFB4A4160076C13CA53F42EC16B3177149CF36EABE56F4B8411D9D30DCF04CB12BEADB3DE8652F6B87590726938866D58EB287671388EED3FEB3876710F7B1A2D68C3A8C69336E22470CEC86544D0A284939C2EBF06B1AF28144FC5BEBC02EECFBE6EB5DEB32A1BC4C65175369BBB508AB6CFC5295687236DDAB8463ED8D5E148455B564729568623943D571DA25C1A8ED16EA0EA70EDA72FCFE5E635D4267475B50E276DA531A42E9A4BB4834CCDCBB81D93BDB87CD34768131ABBFB5E8695B7FC40C3F629F15B6DC2621CD3BC5F9D2BD378DBA67BA0CB6ED3D12644ABF770452C1D6D0FE2F41A93F2DEDF3D2A6C35028588EFA1FBF734364D40B8561A92911118857FB019A3F95D540920EBE802942E5EAEFDA3F1E1913364FCFF0CFC02A5623660EAF76A83386A22BBF3FD7FCF17C8C6EC8DDF1319DD11F95D4256DF3F769EF63830674696FBFE0413B218BFEB41EFC55DB5A539ADC96D6ABD9CCD790CABA9FF67AE77ECCD7FBBA9A91E781712D3E2D81B7B7FD54D684F18F61B8FBDDAC4EA5938E90EA91EC72477F0F438B4FA30A91769EF81D1E36CEA1B020D24FB938F5F1E3B7129E612FB0D59CC9F62B0006928471896221310DA6EC62E25E5114D09ABDBDB6E1386E68B899E85749F7C8414B84982BA5F43F7DAD214595C2775770560CF41547B0EB07BCCD43B652A5A07E4E4ADC0A32DB8D83D77E91A40F5CE9FBA603BC741CF3A9A6A4DA3B60EA3EA71DAF4DDCF327E6AB77AC892DA7FC7485145971B08D3C072881AFCB03273BE1015571D8B2A11A7309D81265884C807A9E982441A1F47A0543E1BFF42589697C15B88E7FC22D369A6D165486E59E35F0C43F76DFBE733B6A6CD938B349F583F850B68263575F482FF9C51165BBB4F3BEA680F84C9A3F2763467690A352CD716E95CF0814065F86CFA5F4392320453173C24F7F010DB90AC9F6049A275D5B1F783EC3E8866D8271F29594A92A81263A38F3F91C371B27AF71FBE3836BA42210000 , N'6.1.3-40302')
END

IF @CurrentMigration < '201612172234483_Initial1'
BEGIN
    CREATE TABLE [dbo].[Categories] (
        [CategoryId] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max) NOT NULL,
        CONSTRAINT [PK_dbo.Categories] PRIMARY KEY ([CategoryId])
    )
    CREATE TABLE [dbo].[Comments] (
        [CommentId] [int] NOT NULL IDENTITY,
        [Content] [nvarchar](max) NOT NULL,
        [Upvotes] [int] NOT NULL,
        [CreationDate] [datetime] NOT NULL,
        [ParentCommentId] [int],
        [Post_PostId] [int],
        [User_UserId] [int],
        CONSTRAINT [PK_dbo.Comments] PRIMARY KEY ([CommentId])
    )
    CREATE INDEX [IX_ParentCommentId] ON [dbo].[Comments]([ParentCommentId])
    CREATE INDEX [IX_Post_PostId] ON [dbo].[Comments]([Post_PostId])
    CREATE INDEX [IX_User_UserId] ON [dbo].[Comments]([User_UserId])
    CREATE TABLE [dbo].[PostCategories] (
        [Post_PostId] [int] NOT NULL,
        [Category_CategoryId] [int] NOT NULL,
        CONSTRAINT [PK_dbo.PostCategories] PRIMARY KEY ([Post_PostId], [Category_CategoryId])
    )
    CREATE INDEX [IX_Post_PostId] ON [dbo].[PostCategories]([Post_PostId])
    CREATE INDEX [IX_Category_CategoryId] ON [dbo].[PostCategories]([Category_CategoryId])
    ALTER TABLE [dbo].[Comments] ADD CONSTRAINT [FK_dbo.Comments_dbo.Comments_ParentCommentId] FOREIGN KEY ([ParentCommentId]) REFERENCES [dbo].[Comments] ([CommentId])
    ALTER TABLE [dbo].[Comments] ADD CONSTRAINT [FK_dbo.Comments_dbo.Posts_Post_PostId] FOREIGN KEY ([Post_PostId]) REFERENCES [dbo].[Posts] ([PostId])
    ALTER TABLE [dbo].[Comments] ADD CONSTRAINT [FK_dbo.Comments_dbo.Users_User_UserId] FOREIGN KEY ([User_UserId]) REFERENCES [dbo].[Users] ([UserId])
    ALTER TABLE [dbo].[PostCategories] ADD CONSTRAINT [FK_dbo.PostCategories_dbo.Posts_Post_PostId] FOREIGN KEY ([Post_PostId]) REFERENCES [dbo].[Posts] ([PostId]) ON DELETE CASCADE
    ALTER TABLE [dbo].[PostCategories] ADD CONSTRAINT [FK_dbo.PostCategories_dbo.Categories_Category_CategoryId] FOREIGN KEY ([Category_CategoryId]) REFERENCES [dbo].[Categories] ([CategoryId]) ON DELETE CASCADE
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201612172234483_Initial1', N'Phase2.Migrations.Configuration',  0x1F8B0800000000000400E51CCB6EE4B8F1BEC0FE83A0D36631DBB23D97ACD1BD8B49CF383032B6076ECF22B7062DD16D2112D511D98E1B41BE2C877CD2FE4248510F3E2552DD969D090618D82259AC17AB8A5545FFFEEFFFCC7F7DCEB3E00996382DD0223C9D9D8401447191A468B30877E4E1A73F86BFFEF2FD77F34F49FE1CFCD6CC7BCFE6D195082FC24742B6E75184E34798033CCBD3B82C70F140667191472029A2B393939FA3D3D308521021851504F3DB1D22690EAB5FE8AFCB02C5704B7620BB2A1298E1FA3B1D595550836B9043BC05315C845F1E018667333E71F689C221FB2B80C0069661F0214B01456905B3873000081504108AF0F9570C57A42CD066B5A51F4076B7DF423AEF016418D6849C77D35D693A39633445DDC20654BCC3A4C83D019EBEAF9914A9CB47B13A6C9948D9C8D9C4A8AE58B9089780C04D51EEC340DDEC7C99956CA2CAE966C5BB807F7FD76A03551AF6EF5DB0DC656457C205823B52828CCEDCDD6769FC17B8BF2BFE06D102EDB24C448B2246C7A40FF4D397B2D8C292EC6FE18382EC65120691BC3E5201B4CB0D6B39599788BC3F0B836B8A0CB8CF60AB05020B56A428E19F2182255D9D7C0184C0920AF13281151F352C943DD9FFCD6E54EDE8510A832BF0FC19A20D795C84F4C730B8489F61D27CA931F88A527AF2E82252EEA0014365D76BF0946E2A8495FDBF1498E030B88559358A1FD32D3F133336B2AE5992423AE7A22CF2DB22AB170943EB3B506E20A16414E6F155B12B6305A979D4295AAFFA3160EEAAC766BF82DAB16DC7A85CB36E2A75BB4B493685BEA927AB40842238FDC65FB74F0561CADBCFE001EC4B5831FF2365790389FD7C97E6871C3DF16C1D76FE9AF3653B7FCDF974C58CBAC0D288131B58D726A343A7FBAA590261E82023C0317235026CF62B1801B6ED1823D0AC9BCA08B0FDD0347E47357700E37F146532FDCE2B901DC3FCF46FF2290769363D6DB7709362AAC92F60A3ECE1C1A029508D92C14A8C3205CB22CF2B5FE21C8DF205AF118CF29D47C5A2DDD2A9CCC2FFB393D6EC544939619381B3837F4CB3A406623E44F5E05A99D99D27E304ED689967F97A7D89E863A2AB0605FD44F998A65E2CF9041DB92A3AB2B1B01A3C5ABCD440E51374542A9B6843A51AF431951F302EE2B4C241E0911843CAF47C4249301050724BD084A3D418504B996EA96DA4DB2FC21F3516D941B64AD081EC120BBD60E79140583FBD8253B2E165F2501D4A5C50323A27B3D9690FA1A6E8D78B6D1EF4990FA00DB301E32108A239F35E840F1CF641F0BAF650CF09990D4A41469D110B69524474379BA238DD82CC854A65B19F9766A2697753473EC22D44CCB3BA70C3050DCDE7E8C8B47B2AC1C410DF466858A5B74392972DE908815B403A9E235D3F47105A9DF821AC643B7D144225EBEE6D81AC8472CFC04239AA03B06C2E26D5571A0E812A2636C4CE74DB3A7CC67514A712C020AC2031242F3A6FA419768D0D3294FAFEA001E0D21E58CC38655ACC3938B0B88B5E74EC1BA12A20048ECB1448591A61962591A31EEB6137DC22DF724CB30DC38E570022E2AB5E4C642A1D38205E0475E26D1E79C8270BD8D672EE21D9E08287583682504BF4ABD3ECE0A53DFCB428B776D31E66F4BB65076807B0869F5B3B4774AF32EC57C6D22F79921754076E6EEC34EB0E66D8C58CA559722A4347A887E6E686D1FA91AECA1AF1326B538E8D2CF5D8F915D86E53B411EAB3F59760C58BB3CB9F56FEC5CA9CC388626CA859B6D8B63B91A2041BA88C327625F0222D31611EF11EB07CC032C9B569AAD7B478946637CD31EAF26A3C4DB384FD5CFB117BA9BA73A77A185903BAA0643205A82886BAA5372CAD0AE62003654F11745964BB1C0D1556FBA0F1F2A608877FD121CC2385162DFAD5D8A768B32A102771D95CD3384999EC9B8394CCCB6C3C6D6A862257CDF5C73E2875255004527F7287D1660C2545693EBAC3691380229CF6A3073E520E50424A1A7933DAC7EDF2B1B4CFE4691CB4CFBCCC2AABBA582589CA58F81A828234DBD07D7587D49594A4F3D07E7587C44B442214FEC51D425DFF1141D49FDC61E8C51C119C3EFA6674B927D01DE9F6EA7BD808AF675B6937646DD6453665D6644C1FAC6FC528DA8F9C92A9924FDE401AEBE515540E6B757F2FDDD7DD1DBBB4CCE4C26DC1160BD40D3EDC70D3D759E51501AC6D6100E3588B823F76D62CE6A80872DD174ADA3155AF2BDEA2171315EE0EB559E112B31958A9A7361CB968F3B36B9BB3F594B19E333950F9BC71A2363149AB8CEC2566F5D9B636EB48F2C10A21672DBC9C52BDC6D1F118D86FCA52BC91D36FCAC2B81E7D6F3F7AB886F4907E340DE1391E3F0DE16B0ED71031A7F3466C872967F58635E4201BA2A5C2D4296D34D3A6C494D4D7BC4E430DBF57D0F2527C4A1850F29FD284E5A4567B4C603E631366ABBF67CB2CADC2CA660255C2F40162C2FB96C2B393D333E5A5C3DB797510619C6486349EE9E9812CB457780990A2C6DCF7355879B6195D0B4D98E80994F123287FC8C1F31F0620F9F5CE8FE0DD71DAD95F84675207BB0FD30C52961BDE0E03A634B155B41FA1852DA13F93312D6C92D11370D22ABF972881CF8BF09FD5BAF3E0F2AF6B61E9BBE0A6A466E53C3809FE25A2A077C3FAB5728FD0C9E37457BF884EAA0DD5876992DA247D1834B1F1D90AC9BBB9F9309C6C0DCB8ECAEEDD2A3CC67B1CB175F74574EE9B365E96FE5B5703A62C773762668FB636B835172CBAA58760F0660DB93DE5E51E64D8EFACF680AE277FE416A1BC9C3CDD4E8A890E3F540C203C501ADD3F6CBCEB29AD47835D7BA7DADDF7067D84192430F810F3BBC812E018243A23D94DB06FEFAEEF4CC1C1B1D33818D9826A29FBBAC6D5814F9F695FA279C4319BA2A7D4259D2C36B398A46893E037A84D5ED2EDCFA5BF9C563926F327D02EC79EFF43DBFC9D6CDB9134C052C877BD13794BDE79AF9E04E284BDE95EAF1F8EF7D081E7CFA67ED730FD13868A4E27CFF2BFF362C1E9F4BAA9C1842A30655CE1A36EAF1F5238BDDE3886D99F5EE8531A7F1FA14F6DFF95B24B2B78B57557959CF19DCABEF7950A2FB32CC2E4BEA082E6F7A69E3712EA1EDC9668F0EB12B101B6B9055D05CBB555035BD7150D60CD5DDE1A471AEDD519D28C18F9617B2D60E2460FD7E5611B777AB8EFF20CA76DA41F7C8D63295F6AAE43EDFC187A81A372406F123AFC0582EDA5CF30D1E672B2F10E26D6AE2DA8BF0AF1477A76A43D9318246E5017DEE0D322D38B129707253CE41D5EFB7A4F86FC4FA7074B5EEF5590BF6A1E872C8F873F7A570375F6C2DF6AA4C1064E371D08D6AB81602CB9F976CE257A289A9043C1A899A26451AF2001098D013E94247D0031A1C331C4B8FA9325BF816C5755ACEE6172896E7664BB23946498DF6792E961514BDFFED5EB2619E7F9CDB6FA1B0FC72081A299B212C90DFAD38E1EE716EF0B43CAD602828543755189C992D5D4E066DF42BA2E9023A09A7D6D147707F36D4681E11BB4024F700C6E54653FC30D88F74D738A1DC8B02064B6CF3FA66053821CD730BAF5F457AAC349FEFCCB7F016E5D2F0CB2540000 , N'6.1.3-40302')
END

IF @CurrentMigration < '201612252042070_InitialCreate'
BEGIN
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201612252042070_InitialCreate', N'Phase2.Migrations.Configuration',  0x1F8B0800000000000400E51C5D6FE336F2BDC0FD07414FD7626B25D997BBC06EB1F56E8AA04DB288B3C5BD198CC4384225CA95E834C6E17ED93DDC4FBABF70A4A80F7E4AA464CBB9160B2C128A1CCE17678633C3FCF7DFFF997FFF9A26DE0BCC8B38430BFF7C76E67B10855914A3CDC2DFE1A76FFFE67FFFDD5FBE9A7F8AD257EF977ADE7B3A8FAC44C5C27FC6787B190445F80C5350CCD238CCB3227BC2B3304B031065C1C5D9D9DF83F3F30012103E81E579F3FB1DC2710ACB5FC8AFCB0C85708B7720B9C9229814D538F9B22AA17AB72085C5168470E17F7E0605BC98B189B34F040EDEDF00043630F7BD0F490C084A2B983CF91E4028C30013842FBF147085F30C6D565B32009287FD1692794F20296045C8653BDD96A6B30B4A53D02EAC4185BB0267A923C0F3F715930279F92056FB0D13091B199B28D5252B17FE1260B8C9F2BDEFC99B5D2E939C4E94395DAF78E7B1F1778D3610A5A1FFDE79CB5D8277395C20B8C33948C8CCDD6312873FC1FD43F62B440BB44B121E2D8218F9260C90A1CF79B68539DEDFC32709D9EBC8F702717D200368966BD632B2AE117E7FE17BB70419F098C0460B3816AC7096C31F218239591D7D0618C39C08F13A82251F152CA43DE9FFF56E44EDC851F2BD1BF0FA33441BFCBCF0C98FBE7715BFC2A81EA930F8826272F2C8229CEFA0064369D75BF0126F4A84A5FD3F67052E7CEF1E26E5D7E239DEB23331A35FD6154B6248E65CE5597A9F25D522EED3FA01E41B88091999FEFB2ADBE5A184D43C6815AD53FD28307BD5A3B34FA07674DB212A57AF9B4ADD1E629C4CA16FF2C9CA1026084EBFF197ED4B86A9F27633B807FB1C96CCFF48585E43A23F3FC4E998A3C79FAD71E7AF3E5FA6F3579F4F6BCCB23425E2D2E3557D5CB373D922C58F2B1641F8A833075DE8108F9C6B51A11FD695056B1169471534B84FA36C52458E8347640B4EE110D9CE83FC61BB742AFBF4673614B26B0039E1844906D647F9394E22ABF32CCD540FB63041B139FA59AE964720FA90E89A0C929E2897E869B89134B150B0A0A38D640D954D5051296DA20995F2A30E156B53C9B6B5B59374F6098C24DD768885ACD74D651EE97E689A1B8372308BE2F72C8FA6DF79059243F883EE4D3EA5204EA6A7ED1E6EE28268F211A24BF3C5AE376A928D8126A0B231051F8A220BE372770E273EA41549F98422AF27BE65E2A9A3632221620FE22DB10064FB85FF8DC21D33C8C61FB420DB3C4727D879C011D64DAFDE579950ECF1B31CA2B57B14F13C9BCDCE3B38D0E3177BC1ABDC25F61352771D8384C46D548F638455631BA330DE82C4864A69B15B404B45D3EC267FF908B710512B6BC30D1B3494F04C45A6D953F22A7D7C1BA061E571E893BC18740C10B801A4468774C753D54F074239A365C24967C15A8C581CE27462741749270B344090259A7D5C1743B683085208F49CD966249479067AAB233A0EF3DADB96A3C4C98132ECD3848764DB2A422C2AD72A134021AC20D6E4525A6FA41876850D2294CA292A0098A87B16B7771115815A2E3D2028B375EB9910A4C51CC7450A84A41137CB905792CD56BF1B6ED06E38A6D8BE7EC7CB01E1F1952370914A0B0E18EE872A1F2C9CB3837BE6C96936ED604BB737B6803682354C9DCD1C519D49BF3B194ABFE040FA146B00CD7CB0AB526CF22A7D7E8543B43AB31DA46ADCC8110815AFF966E1AA0EA6DFC50C15AEE054FA78D641737DC368FC485BF40D58D5B7AE0E0786F2F0FC066CB7E452C7958BAB116FC56AC5CB6F57EEB5D394C108C24253426DB06D7622977FB081D257CAAE085EC57981A9477C04F496B78C52659AEC350DBEA4DE4D718CAABC6A37532FA13F577EC45C396FDDA91A265780AE089954014A8AA16AE9354BCBFA3D4840DE51935D66C92E457D75DE2E68ACDACAC361232A847920D1A244F70AFB246D960562252E932D1A26299D21B790927E9989A7750993E7AABE1CDA05A52A4CF240AA217B184DF14050947AD01E4E530BE0E134830EF808E5000129E1CB9BD1BE8E2868A0A9A802DF0196C2B4D22CFCE6262E8ADF7841FF332892F1D0CAD90BE1F4F6A5364EA6A02C70389476EA42210BD5D42F33EA4055221054405B6EE8838214E7D58EBA48BE4EE48B22AF47ED21B1C43C0F858DD843A8B2EE3C886AC81E869A42E7C1A95FA7D76531AC55FDBD705FB777ECC2329D0B37055B3450D7F870CD4D5F65955304B036850194630D0AEED819B3B48322C875572869C654BEAE388B5EBC8D3BF9D36A8DA5CFD4705477FB7E23C2D665176C25ED1C0274E2461C7E149729DAEB8296E19A129C25E9A33584CF5DD87BB47A854D54AFE1BF9AEDB0E4BEC9D1AD4DDECE5131D434CA488D3D8E4274907C3093C1723C6E2683AD196F32F89CCE1BD10C5DCEEA0D9B8C511AA2A4C2E4294D34D3A4C4A4D4D7BC4A43F53F9F50F2526C8AEF11F25FE288E6A456FB02C3744627CC56BF25CB242EAF48F504A284F1132C30EBCEF12FCECE2FA487176FE71144501451A249E3E95E4288423BC1C38418D5FEBFAB99C8B11BE596EB2C422F200F9F41FED714BC7EDD03C9AD957F00EF0ED35D7F149E090DF52E4CD34859EC7D1D074CEA672D693F40376B447EC643BA5905A3C7E1A4547EAF51045F17FE3FCB7597DEF53FD6DCD277DE5D4ECCCAA577E6FD8B47416DF1726EE51E72A40FD85A7D14E5FC436B94A13FDA56ABA4E5F69AA537336B8DADB1C1A25D3A0683377BBA34ED2C1336E41EE550C93DB8E34E95DC573B0E1ADF2B6B84E4DC0F3B0E27538FABE5C1770A2EC60468DD490C7340D7913FB28B508E673AEC8CB28E0E375434201C501ADC3FACBDEB49AD47BD2D7BE7CADDF70E7D8409C4D0FB10B2BBC8121421885446D29B60D7DE6DDF99848365A7B137B0C5D650F6B58DAB3D973EDAAE44F380633645CFAC4D3A996F66D149D124C13FA0363949B73B977E3CADB24CE64FD891EDD4F37FB8F67E965599BA9B7FFAC6FD924E2B7BF3FFD3A76FE5AFECD460421598D2DBB8A8DBE91D8DE59B85B1CF14ACD4E640C236B44CD85EE09C9D80F55E1DB584098F77E7EB8D43C87AFAE33DA5C45D8EF7D44297CA2E8DE0E5D65D5972DA772AFBCE572AACCC426EC88F191134BB3775BC9190F760C75F815FF50C6860EB5BD015D46B355331AFBF681137BD5F90E1B3D3A000AFEA961AC8FA2E721D373AB82E7E3671A783FB36CF709A46FADED73886F2A562EDE5BA7EDF0B1C99036A93D0F81708A6973EFD44EBCBC9DA3B185FBB36A07E12E28FFDEC48F708C3E60D06BB0FF4AF3DDD732277857660C9E95E0C290F5E7AD5B49709A77B15E44ED06164E4F0F047ED6A20CE9EFBD39124D828E24D0B82F66A20180A6EBE99738D9EB23AE49030AAA74859D41B88414462800F398E9F4088C9E7101645F977247E01C9AECCA93FC2E81ADDEDF0768709C9307D4C04D343A396AEFDCBD74D22CEF3BB6DF9D71D0E41024133A649F93BF4C38ED8A606EF2B4DCAD60082864355A985CA9266FDE166DF40BACD9025A08A7D4D14F700D36D4280157768055EE010DC88CAFE0C3720DCD7CD296620FD8210D93EFF18834D0ED2A282D1AE27BF121D8ED2D7EFFE07262B973141550000 , N'6.1.3-40302')
END

IF @CurrentMigration < '201701121639055_AddedUserRoles'
BEGIN
    CREATE TABLE [dbo].[UserRoles] (
        [UserRoleId] [int] NOT NULL IDENTITY,
        [RoleTitle] [nvarchar](max) NOT NULL,
        CONSTRAINT [PK_dbo.UserRoles] PRIMARY KEY ([UserRoleId])
    )
    ALTER TABLE [dbo].[Users] ADD [Role_UserRoleId] [int]
    CREATE INDEX [IX_Role_UserRoleId] ON [dbo].[Users]([Role_UserRoleId])
    ALTER TABLE [dbo].[Users] ADD CONSTRAINT [FK_dbo.Users_dbo.UserRoles_Role_UserRoleId] FOREIGN KEY ([Role_UserRoleId]) REFERENCES [dbo].[UserRoles] ([UserRoleId])
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201701121639055_AddedUserRoles', N'Phase2.Migrations.Configuration',  0x1F8B0800000000000400E51DDB6EE3B8F5BD40FF41D0535BCC5A49E6A50DEC5D4C3D9322E8663288338BBE198CC438427571253A8D51F4CBF6613FA9BF5052D4857791922D7B7631C02011C9C3733F87873C33FFFBF997F90F6F69E2BDC2A28CF36CE15FCE2E7C0F66611EC5D966E1EFD0F3777FF67FF8FEF7BF9B7F8AD237EFA766DE7B320FAFCCCA85FF82D0F63A08CAF005A6A09CA57158E465FE8C66619E0620CA83AB8B8BBF04979701C4207C0CCBF3E60FBB0CC529AC7EC1BF2EF32C845BB403C95D1EC1A4ACBFE3915505D5FB0C52586E410817FE971750C2AB199D38FB84E1A0FD1DC8C00616BEF72189014669059367DF035996238030C2D75F4BB842459E6D565BFC01248FFB2DC4F39E4152C29A90EB6EBA2D4D175784A6A05BD8800A7725CA53478097EF6B2605E2F241ACF65B266236523611AA2B562EFC25407093177BDF1337BB5E2605992872BA59F1CEA3DFDFB5DA809586FC79E72D7709DA157091C11D2A408267EE9E9238FC3BDC3FE6FF84D922DB25098B16460C8F711FF0A72F45BE8505DA3FC06701D9DBC8F7027E7D200268972BD652B26E33F4FECAF73E6364C053025B2D6058B0427901FF063358E0D5D11780102CB0106F2358F151C242D893FCDDEC86D50E9B92EFDD81B71F61B6412F0B1FFFE87B37F11B8C9A2F35065FB3185B1E5E848A1D546028ECFA19BCC69B0A6161FF2F79894ADF7B8049355ABEC45B6A133332B2AE5912433CE7A6C8D3873CA9173143EB47506C20C264E4EAF155BE2B4201A979D0299A51FD08307BD523B34FA07664DB212AD7AC9B4ADD1E63944CA16FA265E519C2084EBFF1D7ED6B8E88F29A19DC837D012BE67FC42C6F20919F1FE3748CE9B1B635CEFE1AFBD2D95F639FD698E5698AC5A5C6AB1E5C53BBEC9062BF4B1E811B54B903133A3822174A54C8C0BAF6601D22DD57090D6668944FAAC971888874C1290222DD79503CEC964EE59F7ECB8E420C0DA0C09CD0C9C0DA945FE224B2B26761A66CD8DC04C9E7A867B97A1E8EE843A2AB73486AA25CB2A7E14E52C742CE831EC649AA18C50DA85DA59131D6DE92A266EB2AC9EC13F849B2ED1027D9AC9BCA4392FDB2690E0D926D96E5BFF3229A7EE715480E1112CC9B7C4A419C4C4FDB03DCC425D6E463249826B76FE916441FA5761AE34F9BBDA99C12113ECBB3C58200D0224106D7E40709916E44E92C99E1D1DE9262E8E231C98A13794DB2F550CFD9AC9DCA7B92FDA63A031B43B5DE0AAC1450650D0AFDB451C00F65998771850963A5ECC99327EB5316793DC750CAD9E6108B998BB52FDE627DC3DB2FFC3F499CD2836C0DAD03D995238D60E7014398995E754AA943B1271D66106DB2581ECF8BD9ECD2C0819EF4B517BCCC5D6CAD9064D53148F0F18AC49A3843B269C759186F416243A5B0D8EDDC4944D3EE268E7C845B98115BB6E1860D1AD2294A46A6DD53F05F7D7C1BA0619539F4499E3F1B0C10B806A4428754E629EBA703A17C56A1434B93627478D1138393DD684E33AEEC73A595A62C46A484FC653C95426DCBC9DB3AD2C70423134AAAC8C4D349331A675A5539979981B6F4D26048EA4DD8AC61D11C02AAAF38F706556EA5C8C1F09E751A56D68980883F81B0824851E5ED02B014CB242EF050EACC58024025DEB3B8CBF265041AA3E80151E723D27A2A018BC544903A00543704208CD878367035716696A66C2EBAFBFEF4A545BF65BB1433FA131606088BAF9823F3545A704053FE92F96091D438A4352C39EDA606B698B3180B682358436D42CF113908F787E1A1F47381B74FB106D02C9CE265A20D01D922243318D71EC040B33A021F47D66CB94043B42232F7C5667772F9507C2401B3274235B1BA306D13A805A26B47DD43B8222EF731CF407C73346DA371F7A827A0AF7A9AD73F81E6F9CFFC0E6CB7F820CF3C07AABF782BFA1668F9DDCAFD6D4C4A610461A97822D362DBEE84F2026CA0304AF43E823771512292573C01522A5846A9344DCC3D3441B5D94D4A2F648935B1B659427EAE03A9FE65549794C8E7AB1AD00D26935872453194439D62A947DE67810414863737CB3CD9A559DF3B1E1334FA9A868543BFC810E681408B742C94D82768B328102B71E99CD23049A922998594D4CB743C6D9EA8B05C553F773141A98B6E2C90FA933D8CF672985394E6A33D9CF6AE9785D37E74C087BBEEE590E246CE46FB0C79C04057511F1F06780ADD4ABDF0DB120E2F7E6D65E7B7A0485AA315CB5E9CF5F6D5C44EA6A0BA1466987656875377D5542FD3EA407DFFCBA980F22EB90F4A2605AFEEAB8BE49B5B5A5EE4CD577B48F4D6958542BFD843A8AF545910F5277B18F2FD280B4E1E3D2B5DA6C9F421F5B9AA950CD369F552934636B773A24EAA6FFC8C52ECEEDD38F1759FA7971B7F1C91F334AED0649F9071CB54A9972E4926472C45EEA52851C9AC72CADCD6BAF48D70AC45C11D3BEDB5CCA0CC7F6D3A02E831158F99CEA2E7CB484E7950BDC632D751705455363A1361ABCA62B692764EDD8CB8E1442D8AAB7B8ADB92DCC1B7F7EF96A48FD610A1E866EFBC9945C3754459A9B394842E5959EB32164725519600CF584B0CB41F464BEA32A0838AD42B6CCEEC3A017045CD73D20CAE5A3AD2AF7D9B0AC19672DD92BE6695CD6945C37FB9F8EBA01CAA5CB005A84B080728895C591EA9C1C751941ED2FB9545AA798B53DAF4B7AD7D0B35EE795D6FEEEF83950AD0748AEF6116BCC611293EAFF62582E98C4C98ADFE952C93B8AA853413B036C6CFB044F4B5A07F7571792574D09E4F376B509651A2A8D7AB5A5A79A19DA0C334CE9A84D1F4A8D1F14D312D7AD30DB25750842FA0F8430ADEFED803C9AD277300EF0ED32679149E71AF425D98A69032DFC4340E98D09854D17E80B6A408FF8C86B425711192C1497A28739B45F06DE1FFA75A77EDDDFE63CD2C7DE7DD17D8AD5C7B17DE7F5914E487FACE3D79434CFA803D724751CE5FB546691ADD6CB54A586EAF596A37B356F81A1B2CBAA56330385BEB92D3CC29DBAA8E62546227D538AB12BBA3C641633B9EB4909CBB9AC6E1A4EB541A6CF8520EEDA6F0C2F22329BD5C353F4567CC510C406A86395AAE3826DF361731F5F9B9A17E6C97701E2F12D8C558151D6EA8284038A034B86148595D10DECCF6BE5BBF948A1AF7D947984004BD0F213D5A2E41198248662439DC9BF6EE5E5D0B3858B61679037B6A34CF756C8F499E4BE38CE9A26980994DD12463739DC43EB155495127C15FA1363949D77C97763CADB2BCCC9BB005CBA9C9EF70FD7CB4483675FBDEF49D7A159D56FEE6DB69CCB38A57766A30A10A4C196D5CD4EDF481C6BE49716CBBDEF452D7BC79B33D981F4DEA3D77895349BDBF5D73ACC8AD9CC537286C6B77721E9276685C3D54AFAA6B6BEA18A96B9E01BA94219CA46FAD691657C207D700E122B50DED62D78D283C65A3EEDED8A64B2F4E177EF4946371D3A3B3A1BF53DC83FA02097EFD6C4C015BDD4626A1DE841419F3664489B8AE1F4F844F9559024E3FAB20AB1BC05460A9AD2941D3211D78659F9A92E106C1F2C33A0118046CD3A5DC76DAF5362B6B9E6548D1457C17D4D7A02C72407E8A3ABE5151D708DD4FB4FA9987F2A4CF3E98D3A07E12E28FDD95AD6AA3B5E93FA6A7CEFEB5A7EBB676576807969CBAA15A6A8A3D3561E33BA6DD48B292EE7974452B1BA17BFBA07BD97198AE67F9A5174E9798FF1701E76B65BCE94090376C190CB944A99D739B3DE74DE22660D44C11AE22EE200211CEA23E14287E0621C2C3212CCBEA1F4EFB09243B48EE199F60749BDDEFD0768730C9307D4A38CF4AF23ED3FE556B378FF3FC7E5BFDFB68872001A319938BCAFBECAF3BEC7A5BBC6F14F71E1A1024A1AC6FDF882CC94D28DCEC5B489FF3CC1250CDBE360F7E84E936C1C0CAFB6C055EE110DCB0EAFD083720DC370FF6F440FA05C1B37DFE31069B02A4650DA35B8F7FC53A1CA56FDFFF1F0D8717BE1E640000 , N'6.1.3-40302')
END

IF @CurrentMigration < '201701121725264_AddedUserRoles2'
BEGIN
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201701121725264_AddedUserRoles2', N'Phase2.Migrations.Configuration',  0x1F8B0800000000000400E51DDB6EE3B8F5BD40FF41D0535BCC5A49E6A50DEC5D4C3D9322E8663288338BBE198CC438427571253A8D51F4CBF6613FA9BF5052D4857791922D7B7631C02011C9C3733F87873C33FFFBF997F90F6F69E2BDC2A28CF36CE15FCE2E7C0F66611EC5D966E1EFD0F3777FF67FF8FEF7BF9B7F8AD237EFA766DE7B320FAFCCCA85FF82D0F63A08CAF005A6A09CA57158E465FE8C66619E0620CA83AB8B8BBF04979701C4207C0CCBF3E60FBB0CC529AC7EC1BF2EF32C845BB403C95D1EC1A4ACBFE3915505D5FB0C52586E410817FE971750C2AB199D38FB84E1A0FD1DC8C00616BEF72189014669059367DF035996238030C2D75F4BB842459E6D565BFC01248FFB2DC4F39E4152C29A90EB6EBA2D4D175784A6A05BD8800A7725CA53478097EF6B2605E2F241ACF65B266236523611AA2B562EFC25407093177BDF1337BB5E2605992872BA59F1CEA3DFDFB5DA809586FC79E72D7709DA157091C11D2A408267EE9E9238FC3BDC3FE6FF84D922DB25098B16460C8F711FF0A72F45BE8505DA3FC06701D9DBC8F7027E7D200268972BD652B26E33F4FECAF73E6364C053025B2D6058B0427901FF063358E0D5D11780102CB0106F2358F151C242D893FCDDEC86D50E9B92EFDD81B71F61B6412F0B1FFFE87B37F11B8C9A2F35065FB3185B1E5E848A1D546028ECFA19BCC69B0A6161FF2F79894ADF7B8049355ABEC45B6A133332B2AE5912433CE7A6C8D3873CA9173143EB47506C20C264E4EAF155BE2B4201A979D0299A51FD08307BD523B34FA07664DB212AD7AC9B4ADD1E63944CA16FA265E519C2084EBFF1D7ED6B8E88F29A19DC837D012BE67FC42C6F20919F1FE3748CE9B1B635CEFE1AFBD2D95F639FD698E5698AC5A5C6AB1E5C53BBEC9062BF4B1E811B54B903133A3822174A54C8C0BAF6601D22DD57090D6668944FAAC971888874C1290222DD79503CEC964EE59F7ECB8E420C0DA0C09CD0C9C0DA945FE224B2B26761A66CD8DC04C9E7A867B97A1E8EE843A2AB73486AA25CB2A7E14E52C742CE831EC649AA18C50DA85DA59131D6DE92A266EB2AC9EC13F849B2ED1027D9AC9BCA4392FDB2690E0D926D96E5BFF3229A7EE715480E1112CC9B7C4A419C4C4FDB03DCC425D6E463249826B76FE916441FA5761AE34F9BBDA99C12113ECBB3C58200D0224106D7E40709916E44E92C99E1D1DE9262E8E231C98A13794DB2F550CFD9AC9DCA7B92FDA63A031B43B5DE0AAC1450650D0AFDB451C00F65998771850963A5ECC99327EB5316793DC750CAD9E6108B998BB52FDE627DC3DB2FFC3F499CD2836C0DAD03D995238D60E7014398995E754AA943B1271D66106DB2581ECF8BD9ECD2C0819EF4B517BCCC5D6CAD9064D53148F0F18AC49A3843B269C759186F416243A5B0D8EDDC4944D3EE268E7C845B98115BB6E1860D1AD2294A46A6DD53F05F7D7C1BA0619539F4499E3F1B0C10B806A4428754E629EBA703A17C56A1434B93627478D1138393DD684E33AEEC73A595A62C46A484FC653C95426DCBC9DB3AD2C70423134AAAC8C4D349331A675A5539979981B6F4D26048EA4DD8AC61D11C02AAAF38F706556EA5C8C1F09E751A56D68980883F81B0824851E5ED02B014CB242EF050EACC58024025DEB3B8CBF265041AA3E80151E723D27A2A018BC544903A00543704208CD878367035716696A66C2EBAFBFEF4A545BF65BB1433FA131606088BAF9823F3545A704053FE92F96091D438A4352C39EDA606B698B3180B682358436D42CF113908F787E1A1F47381B74FB106D02C9CE265A20D01D922243318D71EC040B33A021F47D66CB94043B42232F7C5667772F9507C2401B3274235B1BA306D13A805A26B47DD43B8222EF731CF407C73346DA371F7A827A0AF7A9AD73F81E6F9CFFC0E6CB7F820CF3C07AABF782BFA1668F9DDCAFD6D4C4A610461A97822D362DBEE84F2026CA0304AF43E823771512292573C01522A5846A9344DCC3D3441B5D94D4A2F648935B1B659427EAE03A9FE65549794C8E7AB1AD00D26935872453194439D62A947DE67810414863737CB3CD9A559DF3B1E1334FA9A868543BFC810E681408B742C94D82768B328102B71E99CD23049A922998594D4CB743C6D9EA8B05C553F773141A98B6E2C90FA933D8CF672985394E6A33D9CF6AE9785D37E74C087BBEEE590E246CE46FB0C79C04057511F1F06780ADD4ABDF0DB120E2F7E6D65E7B7A0485AA315CB5E9CF5F6D5C44EA6A0BA1466987656875377D5542FD3EA407DFFCBA980F22EB90F4A2605AFEEAB8BE49B5B5A5EE4CD577B48F4D6958542BFD843A8AF545910F5277B18F2FD280B4E1E3D2B5DA6C9F421F5B9AA950CD369F552934636B773A24EAA6FFC8C52ECEEDD38F1759FA7971B7F1C91F334AED0649F9071CB54A9972E4926472C45EEA52851C9AC72CADCD6BAF48D70AC45C11D3BEDB5CCA0CC7F6D3A02E831158F99CEA2E7CB484E7950BDC632D751705455363A1361ABCA62B692764EDD8CB8E1442D8AAB7B8ADB92DCC1B7F7EF96A48FD610A1E866EFBC9945C3754459A9B394842E5959EB32164725519600CF584B0CB41F464BEA32A0838AD42B6CCEEC3A017045CD73D20CAE5A3AD2AF7D9B0AC19672DD92BE6695CD6945C37FB9F8EBA01CAA5CB005A84B080728895C591EA9C1C751941ED2FB9545AA798B53DAF4B7AD7D0B35EE795D6FEEEF83950AD0748AEF6116BCC611293EAFF62582E98C4C98ADFE952C93B8AA853413B036C6CFB044F4B5A07F7571792574D09E4F376B509651A2A8D7AB5A5A79A19DA0C334CE9A84D1F4A8D1F14D312D7AD30DB25750842FA0F8430ADEFED803C9AD277300EF0ED32679149E71AF425D98A69032DFC4340E98D09854D17E80B6A408FF8C86B425711192C1497A28739B45F06DE1FFA75A77EDDDFE63CD2C7DE7DD17D8AD5C7B17DE7F5914E487FACE3D79434CFA803D724751CE5FB546691ADD6CB54A586EAF596A37B356F81A1B2CBAA56330385BEB92D3CC29DBAA8E62546227D538AB12BBA3C641633B9EB4909CBB9AC6E1A4EB541A6CF8520EEDA6F0C2F22329BD5C353F4567CC510C406A86395AAE3826DF361731F5F9B9A17E6C97701E2F12D8C558151D6EA8284038A034B86148595D10DECCF6BE5BBF948A1AF7D947984004BD0F213D5A2E41198248662439DC9BF6EE5E5D0B3858B61679037B6A34CF756C8F499E4BE38CE9A26980994DD12463739DC43EB155495127C15FA1363949D77C97763CADB2BCCC9BB005CBA9C9EF70FD7CB4483675FBDEF49D7A159D56FEE6DB69CCB38A57766A30A10A4C196D5CD4EDF481C6BE49716CBBDEF452D7BC79B33D981F4DEA3D77895349BDBF5D73ACC8AD9CC537286C6B77721E9276685C3D54AFAA6B6BEA18A96B9E01BA94219CA46FAD691657C207D700E122B50DED62D78D283C65A3EEDED8A64B2F4E177EF4946371D3A3B3A1BF53DC83FA02097EFD6C4C015BDD4626A1DE841419F3664489B8AE1F4F844F9559024E3FAB20AB1BC05460A9AD2941D3211D78659F9A92E106C1F2C33A0118046CD3A5DC76DAF5362B6B9E6548D1457C17D4D7A02C72407E8A3ABE5151D708DD4FB4FA9987F2A4CF3E98D3A07E12E28FDD95AD6AA3B5E93FA6A7CEFEB5A7EBB676576807969CBAA15A6A8A3D3561E33BA6DD48B292EE7974452B1BA17BFBA07BD97198AE67F9A5174E9798FF1701E76B65BCE94090376C190CB944A99D739B3DE74DE22660D44C11AE22EE200211CEA23E14287E0621C2C3212CCBEA1F4EFB09243B48EE199F60749BDDEFD0768730C9307D4A38CF4AF23ED3FE556B378FF3FC7E5BFDFB68872001A319938BCAFBECAF3BEC7A5BBC6F14F71E1A1024A1AC6FDF882CC94D28DCEC5B489FF3CC1250CDBE360F7E84E936C1C0CAFB6C055EE110DCB0EAFD083720DC370FF6F440FA05C1B37DFE31069B02A4650DA35B8F7FC53A1CA56FDFFF1F0D8717BE1E640000 , N'6.1.3-40302')
END
