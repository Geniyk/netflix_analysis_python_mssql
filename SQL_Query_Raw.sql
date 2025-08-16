
drop table [dbo].[netflix_raw]

CREATE TABLE [dbo].[netflix_raw](
    [show_id] NVARCHAR(10) primary key,
    [type] NVARCHAR(10) NULL,
    [title] NVARCHAR(200) NULL,
    [director] NVARCHAR(250) NULL,
    [cast] NVARCHAR(1000) NULL,
    [country] NVARCHAR(150) NULL,
    [date_added] NVARCHAR(120) NULL,
    [release_year] INT NULL,
    [rating] NVARCHAR(100) NULL,
    [duration] NVARCHAR(100) NULL,
    [listed_in] NVARCHAR(100) NULL,
    [description] NVARCHAR(1000) NULL
)


GO


