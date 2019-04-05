package com.mmall.util;

import org.artofsolving.jodconverter.OfficeDocumentConverter;
import org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.OfficeManager;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.regex.Pattern;

/**
 * @author hwl_sz
 * @desc 需要OpenOffice第三插件的支持 ,支持window\linux\mac等系统
 */
public class OfficePDF {
    public static final String[] OFFICE_POSTFIXS = {"doc", "docx", "xls",
            "xlsx", "ppt", "pptx"};


    /**
     * 根据操作系统的名称，获取OpenOffice的安装目录
     * 如我的安装目录：C:/Program Files/OpenOffice 4
     */
    private static String getOfficeHome() {
        String osName = System.getProperty("os.name");
        if (Pattern.matches("Linux.*", osName)) {
            return "/opt/openoffice4";
        } else if (Pattern.matches("Windows.*", osName)) {
            return "C:/Program Files (x86)/OpenOffice 4";
        } else if (Pattern.matches("Mac.*", osName)) {
            return "/Application/OpenOffice.org.app/Contents";
        }
        return null;
    }

    /**
     * 转换文件
     *
     * @param inputFilePath  转换的office源文件路径
     * @param outputFilePath 输出目标文件路径
     */
    private static void converterFile(String inputFilePath, String outputFilePath) {
        File inputFile = new File(inputFilePath);
        File outputFile = new File(outputFilePath);
        // 假如目标路径不存在,则新建该路径
        if (!outputFile.getParentFile().exists()) {
            outputFile.getParentFile().mkdirs();
        }

        DefaultOfficeManagerConfiguration config = new DefaultOfficeManagerConfiguration();
        // 获取OpenOffice 的安装目录
        String officeHome = getOfficeHome();
        config.setOfficeHome(officeHome);
        // 启动OpenOffice的服务
        OfficeManager officeManager = config.buildOfficeManager();
        officeManager.start();

        OfficeDocumentConverter converter = new OfficeDocumentConverter(
                officeManager);

        converter.convert(inputFile, outputFile);
        System.out.println("文件：" + inputFilePath + "\n转换为\n目标文件：" + outputFile
                + "\n成功！");

        officeManager.stop();
    }

    /**
     * 将(.doc|.docx|.xls|.xlsx|.ppt|.pptx)等office文件 转化为pdf文件
     *
     * @param inputFilePath  待转换的源文件路径
     * @param outputFilePath 输出的目录文件路径，如果未指定(null)，则按在源文件当前目录生成同名的pdf文件
     * @return 处理结果
     */
    public static boolean openOffice2Pdf(String inputFilePath, String outputFilePath) {
        boolean flag = false;
        File inputFile = new File(inputFilePath);

        ArrayList<String> office_Formats = new ArrayList<String>();
        Collections.addAll(office_Formats, OFFICE_POSTFIXS);
        if(null == inputFilePath)
            System.out.println("null == inputFilePath");
        if(!inputFile.exists())
            System.out.println("!inputFile.exists()");
        if ((null != inputFilePath) && (inputFile.exists())) {
            // 判断目标文件路径是否为空
            if (office_Formats.contains(getPostfix(inputFilePath))) {
                System.out.println("111");
                if (null == outputFilePath) {
                    System.out.println("222");
                    // 转换后的文件路径
                    String outputFilePath_new = inputFilePath.toLowerCase().replaceAll("."
                            + getPostfix(inputFilePath), ".pdf");
                    converterFile(inputFilePath, outputFilePath_new);
                    flag = true;
                } else {
                    System.out.println("333");
                    converterFile(inputFilePath, outputFilePath);
                    flag = true;
                }
            }
        }
        return flag;
    }


    /**
     * 获取文件的后缀名
     */
    private static String getPostfix(String inputFilePath) {
        String[] p = inputFilePath.split("\\.");
        if (p.length > 0) {
            return p[p.length - 1];
        } else {
            return null;
        }
    }

    /**
     * @param args
     */
  /*  public static void main(String[] args) {
    OfficePDF.openOffice2Pdf("c:/Users/Y/Desktop/第1章 计算机网络基础.ppt", "c:/Users/Y/Desktop/1.pdf");
}*/
}

