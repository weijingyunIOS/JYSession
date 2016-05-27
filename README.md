# JYSession
针对iOS客户端的网络封装（NSURLSession），如断点下载

JYBreakpointDownload 与 JYDownLoad 都是对断点下载的一个封装。
最初是想用一个方法调用下载（JYBreakpointDownload）但所有数据全部存到了一个数据表，不适合多类下载，故再修改出了JYDownLoad，Demo 也分了两类下载进行展示 video 和 book.

