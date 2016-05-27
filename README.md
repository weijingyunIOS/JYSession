# JYSession
针对iOS客户端的网络封装（NSURLSession），如断点下载

JYBreakpointDownload 与 JYDownLoad 都是对断点下载的一个封装。
最初是想用一个方法调用下载（JYBreakpointDownload）但所有数据全部存到了一个数据表，不适合多类下载，故再修改出了JYDownLoad，Demo 也分了两类下载进行展示 video 和 book.
数据库存储用的是我写的 [JYDatabase（对FMDB的封装）](https://github.com/weijingyunIOS/JYDatabase)地址,极大简化数据库的使用。

![enter image description here](http://imgdata.hoop8.com/1605/8993412352730.png)


	ArtNetWorkService是全局单例管理了，数据库以及下载。根据 EDownloadType 来创建分配JYDownloadManager。
	各种下载都有自己附带的下载信息，在JYBreakpointDownload中用了个extenInfo字典来扩展额外信息，但是所有的数据都存在了一个表中，使用起来不是很方便。
	在JYDownLoad 针对每类下载都有自己的 数据表 这样扩展性也强很多。数据表 继承JYDownLoadTable 这个类提供了一些针对下载的简单查询。 数据对象 继承JYDownloadInfo 这个类是下载的基本信息。
	 需要重写 用于保存数据库， 和通过 查询self.urlString
	 
	- (void)saveToDB{
    	[[ArtNetWorkService shared] insertBook:self];
	}

	- (instancetype)getDBInfo{
        return [[ArtNetWorkService shared] getBookByUrlString:self.urlString];
	}
	
	
重要：JYNetWorkConfig 配置

	1.EDownloadType 每一个新的下载类型添加一个枚举
	typedef NS_ENUM(NSUInteger, EDownloadType) {
    	EDownloadBook,
    	EDownloadVideo
	};
	
	2.主目录
	@property (nonatomic, strong) NSString* netWorkDirectory;
	如果要群分用户，在该目录拼接 userID路径
	
	3.根据情况实现下面方法
	// 每个EDownloadType 对应NSString 也是对应下载目录
	- (NSString *)getDownloadType:(EDownloadType)aType;
	
	// 下载类型最大下载数 默认是 3.
	- (NSInteger)getMaxDownloadForType:(EDownloadType)aType;
	
	// 超出 最大下载数 后的提示信息
	- (NSString *)maxDownloadErrorForType:(EDownloadType)aType;


