Use CityGuide
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.Users'))
	CREATE TABLE [Users] (
	Id int NOT NULL IDENTITY(1,1),
	UserName nvarchar(50),
	FirstName nvarchar(50),
	LastName nvarchar(50),
	Avatar nvarchar(MAX),
	PhoneNo nvarchar(15),
	WhatsappNo nvarchar(15),
	Email nvarchar(MAX),
	[Password] nvarchar(100),
	IsAdmin bit default(0),
	IsRetailer bit default(0),
	IsDeleted bit default(0),
	CreatedOn datetime NOT NULL default(getdate()),
	LastModifiedOn datetime
	)

GO


IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.ServiceCategory'))			
CREATE TABLE ServiceCategory(
	Id int NOT NULL IDENTITY(1,1),
	Name nvarchar(100),
	Description nvarchar(MAX),
	Image nvarchar(MAX),
	CreatedOn datetime NOT NULL,
	IsDeleted bit default(0)
)

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.Services'))	
	CREATE TABLE [Services](
	Id int NOT NULL IDENTITY(1,1),
	CategoryId int NOT NULL,
	ProvidedBy int NOT NULL,
	ServiceName nvarchar(100) NOT NULL,
	Description nvarchar(MAX),
	Image nvarchar(MAX),
	Address1 nvarchar(100),
	Address2 nvarchar(100),
	Area nvarchar(50),
	CityId int,
	DistrictId int,
	StateId int,
	PinCode nvarchar(20),
	[Like] int,
	Dislike int,
	CreatedOn datetime NOT NULL,
	IsDeleted bit default(0),
	)
	
GO


IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.CommentFeedback'))			
CREATE TABLE CommentFeedback(
	Id int NOT NULL IDENTITY(1,1),
	FeedbackId int NOT NULL,
	UserId int NOT NULL,
	[Like] bit,
	Dislike bit,
	CreatedOn datetime NOT NULL,
)

GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.Feedback'))			
CREATE TABLE Feedback(
	Id int NOT NULL IDENTITY(1,1),
	ServiceId int NOT NULL,
	[Comment] nvarchar(500),
	[Like] int,
	Dislike int,
	CommentedBy int,
	CreatedOn datetime NOT NULL,
	IsDeleted bit default(0)
)
	
GO	

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.GeneralServiceHour'))			
CREATE TABLE GeneralServiceHour(
	Id int NOT NULL IDENTITY(1,1),
	ServiceId int NOT NULL,
	[Day] nvarchar(15),
	OpeningTime time,
	ClosingTime time,
	BreakTimeStart time,
	BreakTimeEnd time
)

GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.OccationalServiceHour'))			
CREATE TABLE OccationalServiceHour(	
	Id int NOT NULL IDENTITY(1,1),
	ServiceId int NOT NULL,
	[Date] datetime,
	OpeningTime time,
	ClosingTime time,
	BreakTimeStart time,
	BreakTimeEnd time,
	IsDeleted bit
)

GO


IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.Location'))			
CREATE TABLE Location(	
	Id int NOT NULL IDENTITY(1,1),
	ParentId int,
	LocationName nvarchar(200),
	LocationType nvarchar(100),
	CreatedOn datetime,
	IsDeleted bit
)

GO

ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED(Id ASC)
GO
ALTER TABLE [dbo].[Services] ADD  CONSTRAINT [PK_Services] PRIMARY KEY CLUSTERED(Id ASC)
GO
ALTER TABLE [dbo].[ServiceCategory] ADD  CONSTRAINT [PK_ServiceCategory] PRIMARY KEY CLUSTERED(Id ASC)
GO
ALTER TABLE [dbo].[Feedback] ADD  CONSTRAINT [PK_Feedback] PRIMARY KEY CLUSTERED(Id ASC)
GO
ALTER TABLE [dbo].[GeneralServiceHour] ADD  CONSTRAINT [PK_GeneralServiceHour] PRIMARY KEY CLUSTERED(Id ASC)
GO
ALTER TABLE [dbo].[OccationalServiceHour] ADD  CONSTRAINT [PK_OccationalServiceHour] PRIMARY KEY CLUSTERED(Id ASC)
GO
ALTER TABLE [dbo].[Location] ADD  CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED(Id ASC)
GO
ALTER TABLE [dbo].[CommentFeedback] ADD CONSTRAINT [PK_CommentFeedback] PRIMARY KEY CLUSTERED(Id ASC)
GO
ALTER TABLE [dbo].[Services] ADD CONSTRAINT [FK_Services_ServiceCategory] FOREIGN KEY(CategoryId)
	REFERENCES [dbo].[ServiceCategory](Id)
GO

ALTER TABLE [dbo].[Services] ADD CONSTRAINT [FK_Services_Users] FOREIGN KEY(ProvidedBy)
	REFERENCES [dbo].[Users](Id)	
GO

ALTER TABLE [dbo].[Services] ADD CONSTRAINT [FK_Services_Location_City] FOREIGN KEY(CityId)
	REFERENCES [dbo].[Location](Id)		
	
GO

ALTER TABLE [dbo].[Services] ADD CONSTRAINT [FK_Services_Location_District] FOREIGN KEY(DistrictId)
	REFERENCES [dbo].[Location](Id)			
GO

ALTER TABLE [dbo].[Services] ADD CONSTRAINT [FK_Services_Location_State] FOREIGN KEY(StateId)
	REFERENCES [dbo].[Location](Id)			
	
GO

ALTER TABLE [dbo].[CommentFeedback] ADD CONSTRAINT [FK_CommentFeedback_Feedback] FOREIGN KEY(FeedbackId)
	REFERENCES [dbo].[Feedback](Id)		
GO

ALTER TABLE [dbo].[CommentFeedback] ADD CONSTRAINT [FK_CommentFeedback_Users] FOREIGN KEY(UserId)
	REFERENCES [dbo].[Users](Id)		
GO

ALTER TABLE [dbo].[Feedback] ADD CONSTRAINT [FK_Feedback_Services] FOREIGN KEY(ServiceId)
	REFERENCES [dbo].[Services](Id)
GO

ALTER TABLE [dbo].[Feedback] ADD CONSTRAINT [FK_Feedback_Users] FOREIGN KEY(CommentedBy)
	REFERENCES [dbo].[Users](Id)
GO

ALTER TABLE [dbo].[GeneralServiceHour] ADD CONSTRAINT [FK_GeneralServiceHour_Services] FOREIGN KEY(ServiceId)
	REFERENCES [dbo].[Services](Id)
GO
ALTER TABLE [dbo].[OccationalServiceHour] ADD CONSTRAINT [FK_OccationalServiceHour_Services] FOREIGN KEY(ServiceId)
	REFERENCES [dbo].[Services](Id)