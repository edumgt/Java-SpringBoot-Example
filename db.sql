IF DB_ID(N'fooddelivery') IS NULL
BEGIN
    CREATE DATABASE [fooddelivery];
END
GO

USE [fooddelivery]
GO
/****** Object:  Table [dbo].[email_confirmation_token]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[email_confirmation_token](
	[token_id] [bigint] IDENTITY(1,1) NOT NULL,
	[confirmation_token] [varchar](255) NULL,
	[created_date] [datetime2](7) NULL,
	[user_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[token_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[meals]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[meals](
	[meal_id] [bigint] IDENTITY(1,1) NOT NULL,
	[description] [varchar](250) NULL,
	[name] [varchar](100) NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[meal_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_meal]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_meal](
	[meal_id] [bigint] NOT NULL,
	[order_id] [bigint] NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[meal_id] ASC,
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_restaurant]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_restaurant](
	[order_id] [bigint] NOT NULL,
	[restaurant_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC,
	[restaurant_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_status]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_status](
	[order_id] [bigint] NOT NULL,
	[status_id] [bigint] NOT NULL,
	[date] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC,
	[status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_user]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_user](
	[order_id] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[order_id] [bigint] IDENTITY(1,1) NOT NULL,
	[date] [datetime2](7) NULL,
	[total_amount] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[restaurant_meal]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[restaurant_meal](
	[restaurant_id] [bigint] NOT NULL,
	[meal_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[restaurant_id] ASC,
	[meal_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[restaurants]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[restaurants](
	[restaurant_id] [bigint] IDENTITY(1,1) NOT NULL,
	[description] [varchar](250) NULL,
	[name] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[restaurant_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[role_id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[statuses]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[statuses](
	[status_id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[types]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[types](
	[type_id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_restaurant]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_restaurant](
	[user_id] [bigint] NOT NULL,
	[restaurant_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[restaurant_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_role]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_role](
	[user_id] [bigint] NOT NULL,
	[role_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_type]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_type](
	[user_id] [bigint] NOT NULL,
	[type_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 2025-03-19 오전 10:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [bigint] IDENTITY(1,1) NOT NULL,
	[blocked] [bit] NULL,
	[email] [varchar](50) NULL,
	[enabled] [bit] NOT NULL,
	[facebook_token] [varchar](250) NULL,
	[password] [varchar](120) NULL,
	[photo_url] [varchar](500) NULL,
	[user_name] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[roles] ON 
GO
INSERT [dbo].[roles] ([role_id], [name]) VALUES (1, N'ROLE_USER')
GO
INSERT [dbo].[roles] ([role_id], [name]) VALUES (2, N'ROLE_OWNER')
GO
INSERT [dbo].[roles] ([role_id], [name]) VALUES (3, N'ROLE_ADMIN')
GO
SET IDENTITY_INSERT [dbo].[roles] OFF
GO
SET IDENTITY_INSERT [dbo].[statuses] ON 
GO
INSERT [dbo].[statuses] ([status_id], [name]) VALUES (1, N'PLACED')
GO
INSERT [dbo].[statuses] ([status_id], [name]) VALUES (2, N'CANCELED')
GO
INSERT [dbo].[statuses] ([status_id], [name]) VALUES (3, N'PROCESSING')
GO
INSERT [dbo].[statuses] ([status_id], [name]) VALUES (4, N'IN_ROUTE')
GO
INSERT [dbo].[statuses] ([status_id], [name]) VALUES (5, N'DELIVERED')
GO
INSERT [dbo].[statuses] ([status_id], [name]) VALUES (6, N'RECEIVED')
GO
SET IDENTITY_INSERT [dbo].[statuses] OFF
GO
SET IDENTITY_INSERT [dbo].[types] ON 
GO
INSERT [dbo].[types] ([type_id], [name]) VALUES (1, N'EMAIL')
GO
INSERT [dbo].[types] ([type_id], [name]) VALUES (2, N'FACEBOOK')
GO
INSERT [dbo].[types] ([type_id], [name]) VALUES (3, N'GOOGLE')
GO
SET IDENTITY_INSERT [dbo].[types] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK6dotkott2kjsp8vw4d0m25fb7]    Script Date: 2025-03-19 오전 10:41:26 ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [UK6dotkott2kjsp8vw4d0m25fb7] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UKk8d0f2n7n88w1a16yhua64onx]    Script Date: 2025-03-19 오전 10:41:26 ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [UKk8d0f2n7n88w1a16yhua64onx] UNIQUE NONCLUSTERED 
(
	[user_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [blocked]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [enabled]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ('') FOR [facebook_token]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ('') FOR [photo_url]
GO
ALTER TABLE [dbo].[email_confirmation_token]  WITH CHECK ADD  CONSTRAINT [FK1nn2s9fe9dn1ive1wd0y99utv] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[email_confirmation_token] CHECK CONSTRAINT [FK1nn2s9fe9dn1ive1wd0y99utv]
GO
ALTER TABLE [dbo].[order_meal]  WITH CHECK ADD  CONSTRAINT [FK1yvbno5g32ogkngct94y8y0gd] FOREIGN KEY([meal_id])
REFERENCES [dbo].[meals] ([meal_id])
GO
ALTER TABLE [dbo].[order_meal] CHECK CONSTRAINT [FK1yvbno5g32ogkngct94y8y0gd]
GO
ALTER TABLE [dbo].[order_meal]  WITH CHECK ADD  CONSTRAINT [FK7h0r8f1gtutdwa1rhagh06x93] FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([order_id])
GO
ALTER TABLE [dbo].[order_meal] CHECK CONSTRAINT [FK7h0r8f1gtutdwa1rhagh06x93]
GO
ALTER TABLE [dbo].[order_restaurant]  WITH CHECK ADD  CONSTRAINT [FK358j86h78ncxk3ai0ugng2063] FOREIGN KEY([restaurant_id])
REFERENCES [dbo].[restaurants] ([restaurant_id])
GO
ALTER TABLE [dbo].[order_restaurant] CHECK CONSTRAINT [FK358j86h78ncxk3ai0ugng2063]
GO
ALTER TABLE [dbo].[order_restaurant]  WITH CHECK ADD  CONSTRAINT [FKjp01o1dxni77938fqwnnh7agp] FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([order_id])
GO
ALTER TABLE [dbo].[order_restaurant] CHECK CONSTRAINT [FKjp01o1dxni77938fqwnnh7agp]
GO
ALTER TABLE [dbo].[order_status]  WITH CHECK ADD  CONSTRAINT [FK48efngdcgl1e9tkfbcalk35gl] FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([order_id])
GO
ALTER TABLE [dbo].[order_status] CHECK CONSTRAINT [FK48efngdcgl1e9tkfbcalk35gl]
GO
ALTER TABLE [dbo].[order_status]  WITH CHECK ADD  CONSTRAINT [FKs8f9s66vmbenpm548ymtiw4j8] FOREIGN KEY([status_id])
REFERENCES [dbo].[statuses] ([status_id])
GO
ALTER TABLE [dbo].[order_status] CHECK CONSTRAINT [FKs8f9s66vmbenpm548ymtiw4j8]
GO
ALTER TABLE [dbo].[order_user]  WITH CHECK ADD  CONSTRAINT [FK4rr5n6sfje9w1em7ynp8slrow] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[order_user] CHECK CONSTRAINT [FK4rr5n6sfje9w1em7ynp8slrow]
GO
ALTER TABLE [dbo].[order_user]  WITH CHECK ADD  CONSTRAINT [FKm7muior2ynl30n8qh9yqembso] FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([order_id])
GO
ALTER TABLE [dbo].[order_user] CHECK CONSTRAINT [FKm7muior2ynl30n8qh9yqembso]
GO
ALTER TABLE [dbo].[restaurant_meal]  WITH CHECK ADD  CONSTRAINT [FK7xuwktuj8npc7twfdr1m3fu8w] FOREIGN KEY([meal_id])
REFERENCES [dbo].[meals] ([meal_id])
GO
ALTER TABLE [dbo].[restaurant_meal] CHECK CONSTRAINT [FK7xuwktuj8npc7twfdr1m3fu8w]
GO
ALTER TABLE [dbo].[restaurant_meal]  WITH CHECK ADD  CONSTRAINT [FKb91043jejuf4v06v1pkndhf71] FOREIGN KEY([restaurant_id])
REFERENCES [dbo].[restaurants] ([restaurant_id])
GO
ALTER TABLE [dbo].[restaurant_meal] CHECK CONSTRAINT [FKb91043jejuf4v06v1pkndhf71]
GO
ALTER TABLE [dbo].[user_restaurant]  WITH CHECK ADD  CONSTRAINT [FK71krgv2rfl0qimx5cvwqmvuo8] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[user_restaurant] CHECK CONSTRAINT [FK71krgv2rfl0qimx5cvwqmvuo8]
GO
ALTER TABLE [dbo].[user_restaurant]  WITH CHECK ADD  CONSTRAINT [FKa8312nnqfryuc1mjin3g3sw4d] FOREIGN KEY([restaurant_id])
REFERENCES [dbo].[restaurants] ([restaurant_id])
GO
ALTER TABLE [dbo].[user_restaurant] CHECK CONSTRAINT [FKa8312nnqfryuc1mjin3g3sw4d]
GO
ALTER TABLE [dbo].[user_role]  WITH CHECK ADD  CONSTRAINT [FKj345gk1bovqvfame88rcx7yyx] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[user_role] CHECK CONSTRAINT [FKj345gk1bovqvfame88rcx7yyx]
GO
ALTER TABLE [dbo].[user_role]  WITH CHECK ADD  CONSTRAINT [FKt7e7djp752sqn6w22i6ocqy6q] FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([role_id])
GO
ALTER TABLE [dbo].[user_role] CHECK CONSTRAINT [FKt7e7djp752sqn6w22i6ocqy6q]
GO
ALTER TABLE [dbo].[user_type]  WITH CHECK ADD  CONSTRAINT [FKgx1oa4kbhp6v2h4fkcs86782y] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[user_type] CHECK CONSTRAINT [FKgx1oa4kbhp6v2h4fkcs86782y]
GO
ALTER TABLE [dbo].[user_type]  WITH CHECK ADD  CONSTRAINT [FKweqmhl781j658kkq0qom81ru] FOREIGN KEY([type_id])
REFERENCES [dbo].[types] ([type_id])
GO
ALTER TABLE [dbo].[user_type] CHECK CONSTRAINT [FKweqmhl781j658kkq0qom81ru]
GO
