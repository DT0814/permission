package com.mmall.service;//import org.apache.http.Consts;
//import org.apache.http.HttpResponse;
//import org.apache.http.client.methods.HttpPost;
//import org.apache.http.entity.StringEntity;
//import org.apache.http.impl.client.DefaultHttpClient;
//
//import java.util.Date;
//
//public class Demo {
//    public static void main(String[] args) throws Exception{
//        DefaultHttpClient httpClient = new DefaultHttpClient();
//        String url = "https://vcloud.163.com/app/channel/create";
//        HttpPost httpPost = new HttpPost(url);
//
//        String appKey = "94kid09c9ig9k1loimjg012345123456";
//        String appSecret = "123456789012";
//        String nonce =  "1";
//        String curTime = String.valueOf((new Date()).getTime() / 1000L);
//        String checkSum = CheckSumBuilder.getCheckSum(appSecret, nonce ,curTime);//参考 计算CheckSum的java代码
//
//        // 设置请求的header
//        httpPost.addHeader("AppKey", appKey);
//        httpPost.addHeader("Nonce", nonce);
//        httpPost.addHeader("CurTime", curTime);
//        httpPost.addHeader("CheckSum", checkSum);
//        httpPost.addHeader("Content-Type", "application/json;charset=utf-8");
//
//        // 设置请求的参数
//        StringEntity params = new StringEntity("{\"name\":\"netease_vcloud\", \"type\":0}", Consts.UTF_8);
//        httpPost.setEntity(params);
//
//        // 执行请求
//        HttpResponse response = httpClient.execute(httpPost);
//
//        // 打印执行结果
//        System.out.println(EntityUtils.toString(response.getEntity(), "utf-8"));
//    }
//
//    public void init() throws ClientException {
//        IClientProfile profile = DefaultProfile.getProfile("cn-shanghai", "<your accessKey>", "<your accessSecret>");
//        //DefaultProfile.addEndpoint("cn-shanghai", "cn-shanghai", "live", "live.aliyuncs.com"); //添加自定义endpoint。
//        client = new DefaultAcsClient(profile);
//        //System.setProperty("http.proxyHost", "127.0.0.1"); //此设置用于设置代理，可用fiddler拦截查看http请求，便于调试。
//        //System.setProperty("http.proxyPort", "8888");
//    }
//}