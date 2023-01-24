## board TABLE
```sql
CREATE TABLE board(
	bno INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    writer VARCHAR(50) NOT NULL,
    regDate TIMESTAMP DEFAULT NOW(),
    updateDate TIMESTAMP DEFAULT NOW()
);
```

## file TABLE
```sql
CREATE TABLE file(
	fno INT AUTO_INCREMENT PRIMARY KEY,
    `uuid` VARCHAR(100),
    uploadPath VARCHAR(200) NOT NULL,
    fileName VARCHAR(100) NOT NULL,
    fileType TINYINT DEFAULT 0,
    bno INT NOT NULL,
    
    FOREIGN KEY(bno) REFERENCES board(bno)
);
```

## USERS TABLE
```sql
CREATE TABLE users(
	userId VARCHAR(50) NOT NULL PRIMARY KEY,
    userPassword VARCHAR(100) NOT NULL,
    usertName VARCHAR(50) NOT NULL,
    role VARCHAR(50) DEFAULT 'USER',
    email VARCHAR(100) NOT NULL,
    emailHashCode VARCHAR(200) NOT NULL,
    regDate TIMESTAMP DEFAULT NOW(),
    updateDate TIMESTAMP DEFAULT NOW(),
    enabled TINYINT(1) DEFAULT '1'
);
```

##USERS AUTH
```sql
CREATE TABLE userAuth(
	userId VARCHAR(50) NOT NULL,
    auth VARCHAR(100) NOT NULL
);
```