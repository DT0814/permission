package com.mmall.controller;

import com.mmall.common.JsonData;
import com.mmall.model.File;
import com.mmall.model.SysProj;
import com.mmall.model.SysUser;
import com.mmall.service.FileService;
import com.mmall.util.FileUpload;
import com.mmall.util.OfficePDF;
import com.mmall.util.Regex;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.Date;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class FileController {

    @Resource
    FileService fileService;

    @RequestMapping("/PDF.action")         //  显示文件
    @ResponseBody
    JsonData PDF() {
        OfficePDF PDf1 = new OfficePDF();
        //System.out.println("111");
        //  OfficePDF.openOffice2Pdf("d:/计算机网络基础.ppt","d:/1234.pdf");
        //   System.out.println("111");
        return JsonData.success(OfficePDF.openOffice2Pdf("d:/计算机网络基础.pptx", "d:/1234.pdf"));

    }

    @RequestMapping("/user/getFileById.action")         //  显示文件
    @ResponseBody
    public ModelAndView getFileById(@RequestParam("id") int id) {
        ModelAndView mav = new ModelAndView();
        return mav;
    }

    @RequestMapping("/user/getFileByPid.action")         //  显示文件
    @ResponseBody
    JsonData getFileByPid(@RequestParam("pid") int pid) {
        return JsonData.success(fileService.getFileByPid(pid));
    }

    /*
     *
     *  上传文件用，pid为项目id
     * */
    @RequestMapping("/upFile.action")
    @ResponseBody
    JsonData upFile(@RequestParam("file") MultipartFile file, HttpServletRequest request, @RequestParam("pfid") int pfid, @RequestParam("pid") int pid,
                    Model model) throws IOException {
        System.out.println("111");
        SysUser user = (SysUser) request.getSession().getAttribute("user");
        if (user == null)
            return JsonData.fail("nologin");
        if (pfid <= 0)
            return JsonData.fail("pfid is null");
        //  uid = 1;//测试时用
        //  System.out.println("utype:" + utype);
        // System.out.println("uid:" + uid);
        if (pid <= 0)
            return JsonData.fail("pid is null");
        String FName = file.getOriginalFilename();
        File file1 = new File();
        System.out.println("FName:" + FName);
        if (FName != null) {
            request.setAttribute("FName", FName);
        }
        Integer type;//
        //  file1.setoldname(FName);
        file1.setPid(pid);//待添加
        if (Regex.isWord(FName)) {//课件，还有pptx和ppt
            //校验其余参数是否合法
            type = 1;
            String filePath = FileUpload.uploadFile(file, "/files/", request);
            file1.setLocation(filePath);

        } else if (Regex.isVideo(FName)) {//视频
            //if (type != 1) return JsonData.fail("I_PramFail");
            String filePath = FileUpload.uploadFile(file, "/video/", request);
            type = 0;
            file1.setLocation(filePath);
        } else if (Regex.isImage(FName)) {//图片
            //if (type != 2) return JsonData.fail("I_PramFail");
            type = 0;
            String filePath = FileUpload.uploadFile(file, "/image/", request);
            file1.setLocation(filePath);
        } else {
            return JsonData.fail("I_PramFail");
        }
        file1.setFname(FName);
        file1.setSize((long) (file.getSize() / 1024));
        file1.settype(type);//非0时，表示是office，提供预览
        file1.setPfid(pfid);
        file1.setUid(user.getId());
        file1.setStartdate(new Timestamp(new Date().getTime()));
        System.out.println(file1.toString());
        fileService.upload(file1);
        return JsonData.success(1);
    }

    @RequestMapping("/updateFile.action")
    @ResponseBody
    @Transactional
    JsonData updateFile(@RequestParam("file") MultipartFile file, HttpServletRequest request, @RequestParam("id") int id,
                        Model model) throws IOException {
        System.out.println("111");
        SysUser user = (SysUser) request.getSession().getAttribute("user");
        if (user == null)
            return JsonData.fail("nologin");

        String FName = file.getOriginalFilename();
        File file1 = fileService.getFileById(id);
        System.out.println("FName:" + FName);
        if (FName != null) {
            request.setAttribute("FName", FName);
        }
        Integer type;//
        //  file1.setoldname(FName);
        if (Regex.isWord(FName)) {//课件，还有pptx和ppt
            //校验其余参数是否合法
            type = 1;
            String filePath = FileUpload.uploadFile(file, "/files/", request);
            file1.setLocation(filePath);

        } else if (Regex.isVideo(FName)) {//视频
            //if (type != 1) return JsonData.fail("I_PramFail");
            String filePath = FileUpload.uploadFile(file, "/video/", request);
            type = 0;
            file1.setLocation(filePath);
        } else if (Regex.isImage(FName)) {//图片
            //if (type != 2) return JsonData.fail("I_PramFail");
            type = 0;
            String filePath = FileUpload.uploadFile(file, "/image/", request);
            file1.setLocation(filePath);
        } else {
            return JsonData.fail("I_PramFail");
        }
        file1.setFname(FName);
        file1.setSize((long) (file.getSize() / 1024));
        file1.settype(type);//非0时，表示是office，提供预览
        file1.setUid(user.getId());
        file1.setStartdate(new Timestamp(new Date().getTime()));
        System.out.println(file1.toString());
        fileService.upload(file1);
        delectFile(request,id);
        return JsonData.success(1);
    }
    /*@RequestMapping("/user/getFile.action")
    @ResponseBody
    ResultData getFile(int id) {
        return new ResultData(1, fileService.getFileById(id));
    }*/

    /*
     * 删除文件,只是删除项目中的某个文件
     * 即删除了原文件，也删除了pdf文件，还有数据库的记录
     *
     * */

    @RequestMapping("/delectFile.action")
    @ResponseBody
    JsonData delectFile(HttpServletRequest request, @RequestParam("id") Integer id) {
        //F.getId();
        //     Integer uid = (Integer) request.getSession().getAttribute("uid");
        com.mmall.model.File f = fileService.getFileById(id);
        // if (uid != f.getUid())
        //   return JsonData.fail("权限问题");
        if (f == null) {
            return JsonData.fail("PramFail");
        }
        // String name1=(String)f1.getLocation()
        String fileName = f.getLocation();
        System.out.println("fileName:" + fileName);
        String path = request.getSession().getServletContext().getRealPath(fileName);
        System.out.println("path:" + path);
        java.io.File file = new java.io.File(path);
        String pdfFileName = path.substring(0, path.lastIndexOf(".")) + ".pdf";
        System.out.println("pdfFileName:" + pdfFileName);
        java.io.File file1 = new java.io.File(pdfFileName);
        if (file.exists() && file.isFile())
            System.out.println("file.delete():" + file.delete());
        else
            System.out.println("file is not exist");
        if (file1.exists() && file1.isFile())
            System.out.println("file1.delete():" + file1.delete());
        else
            System.out.println("file1 is not exist");
        // System.gc();
        int de = fileService.delectFile(id);
        return JsonData.success(10, String.valueOf(de));
    }

    @RequestMapping("/user/downFile.action")//下载文件 这个几乎是没有用的
    @ResponseBody
    JsonData downFile(HttpServletResponse response, HttpServletRequest request, com.mmall.model.File F) {
        if (F == null)
            return JsonData.fail("您要下载的资源已被删除");
        com.mmall.model.File f1 = fileService.getFileById(F.getId());
        if (f1 == null)
            return JsonData.fail("您要下载的资源已被删除");
        // String name1=(String)f1.getLocation();
        //   String fileName = f1.getLocation();
        // String fileName = request.getParameter(f1.getLocation());
        String path = request.getSession().getServletContext().getRealPath(f1.getLocation());
        System.out.println("path:" + path);
        //  System.out.println("fileName:"+fileName);
        System.out.println(2);
        try {
            path = new String(path.getBytes("iso8859-1"), "UTF-8");
            System.out.println("3");
            java.io.File file = new java.io.File(path);
            if (!file.exists()) {
                System.out.println("您要下载的资源已被删除！！");
                return JsonData.fail(-1, "您要下载的资源已被删除！");
            }

            String s = f1.getFname();
            String filename = new String(s.getBytes("GBK"), "ISO-8859-1");
            // 处理文件名
            //   String realname = path.substring(path.indexOf("_") + 1);
            // 设置响应头，控制浏览器下载该文件
            // response.addHeader("content-disposition", "attachment;filename=" + filename);
            response.setHeader("content-disposition", "attachment;filename=" + filename);
            //+ URLEncoder.encode(realname, "UTF-8"));
            // 读取要下载的文件，保存到文件输入流
            FileInputStream in = new FileInputStream(path);
            OutputStream out = response.getOutputStream();
            byte buffer[] = new byte[1024];
            int len = 0;
            while ((len = in.read(buffer)) > 0) {
                // 输出缓冲区的内容到浏览器，实现文件下载
                out.write(buffer, 0, len);
            }
            // 关闭文件输入流
            in.close();
            // 关闭输出流
            out.close();
        } catch (Exception e) {

        }
        System.out.println(4);
        return JsonData.success(1, "OK");
    }

    @RequestMapping("ShowPDF")
    public ModelAndView showOneProj(@RequestParam("pdfpath") String filepath, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("Yulan");
        mav.addObject("filepath", filepath);
        return mav;
    }

}
