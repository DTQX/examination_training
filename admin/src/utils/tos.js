import InspireCloud from "@byteinspire/js-sdk";

const serviceId = "qchtxq"; // 替换成你的 serviceId，可在后台「设置」页面获取
const fileUploadToken = "7881a316-7697-4861-82ff-2f7408db4381"; // 替换成你的客户端上传 token，可在后台「设置」页面获取


class Tos {
  constructor() {
    this.inspirecloud = new InspireCloud({ serviceId });
  }

  upload(filename, file) {
    // 调用 JavaScript SDK 的 upload 方法实现上传，第二个参数为 File 对象
    return this.inspirecloud.file
      .upload(filename, file, { token: fileUploadToken })
      
  }
}

export const tos = new Tos()
