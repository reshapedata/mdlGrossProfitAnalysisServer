#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' rule_fanLiQtyServer()
rule_fanLiQtyServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  token=dms_token
  file_rule_fanLiQty_FileName=tsui::var_file('file_rule_fanLiQty_FileName')
  text_rule_fanLiQty_delete=tsui::var_text('text_rule_fanLiQty_FBillNo_delete')
  text_rule_fanLiQty_FBillNo=tsui::var_text('text_rule_fanLiQty_FBillNo')
  text_rule_fanLiQty_FCustomerName=tsui::var_text('text_rule_fanLiQty_FCustomerName')
  text_rule_fanLiQty_FIndexType=tsui::var_text('text_rule_fanLiQty_FIndexType')
  text_rule_fanLiQty_FStartRealQty=tsui::var_text('text_rule_fanLiQty_FStartRealQty')

  text_rule_fanLiQty_FEndRealQty=tsui::var_text('text_rule_fanLiQty_FEndRealQty')
  text_rule_fanLiQty_FUnit=tsui::var_text('text_rule_fanLiQty_FUnit')

  text_rule_fanLiQty_FRebateProduct=tsui::var_text('text_rule_fanLiQty_FRebateProduct')
  text_rule_fanLiQty_FRebateRate=tsui::var_text('text_rule_fanLiQty_FRebateRate')
  text_rule_fanLiQty_FEffectDate=tsui::var_date('text_rule_fanLiQty_FEffectDate')

  text_rule_fanLiQty_FExpireDate=tsui::var_date('text_rule_fanLiQty_FExpireDate')

  text_rule_fanLiQty_FIndexCustomerName=tsui::var_text('text_rule_fanLiQty_FIndexCustomerName')

  text_rule_fanLiQty_FRebateType=tsui::var_text('text_rule_fanLiQty_FRebateType')





  text_rule_fanLiQty_FStartDate=tsui::var_date('text_rule_fanLiQty_FStartDate')

  text_rule_fanLiQty_FEndDate=tsui::var_date('text_rule_fanLiQty_FEndDate')
#上传文件

  shiny::observeEvent(input$btn_rule_fanLiQty_upload,{
    filename=file_rule_fanLiQty_FileName()
    if(is.null(filename)){
      tsui::pop_notice('请先上传文件')


    }
    else{
      data <- readxl::read_excel(filename,
                                 col_types = c("text", "text", "text","text", "numeric", "numeric",
                                               "text", "text","text", "numeric", "date", "date","date", "date"))

      names(data) <-c('编号',
                      '客户',
                      '指标类型',
                      '计量客户',
                      '实发数量_大于等于',
                      '实发数量_到',
                      '计量单位',
                      '返利产品',
                      '返利类型',
                      '返利_百分比',
                      '生效日期',
                      '失效日期',
                      '返利开始日期',
                      '返利结束日期'

      )


      data <-data [, c('编号',
                       '客户',
                       '指标类型',
                       '计量客户',
                       '实发数量_大于等于',
                       '实发数量_到',
                       '计量单位',
                       '返利产品',
                       '返利类型',
                       '返利_百分比',
                       '生效日期',
                       '失效日期',
                       '返利开始日期',
                       '返利结束日期'

      )]


      data = as.data.frame(data)

      data = tsdo::na_standard(data)
      tsda::db_writeTable2(token = dms_token,table_name = 'rds_t_rule_fanLiQty',r_object = data,append = TRUE)
      tsui::pop_notice('上传成功')


    }


  })


  #查询
  shiny::observeEvent(input$btn_rule_fanLiQty_view,{
    data=mdlGrossProfitAnalysisPkg::rule_fanLiQty_view(token=dms_token)
    tsui::run_dataTable2(id = 'rule_fanLiQty_resultView',data=data)
    tsui::run_download_xlsx(id = 'btn_rule_fanLiQty_download',data = data,filename = '返利数量规则表.xlsx')


  })
  #添加
  shiny::observeEvent(input$btn_rule_fanLiQty_add,{
    FBillNo = text_rule_fanLiQty_FBillNo()
    FCustomerName = text_rule_fanLiQty_FCustomerName()
    FIndexType =text_rule_fanLiQty_FIndexType()
    FStartRealQty = text_rule_fanLiQty_FStartRealQty()
    FEndRealQty = text_rule_fanLiQty_FEndRealQty()
    FUnit = text_rule_fanLiQty_FUnit()
    FRebateProduct=text_rule_fanLiQty_FRebateProduct()
    FRebateRate = text_rule_fanLiQty_FRebateRate()
    FEffectDate = text_rule_fanLiQty_FEffectDate()
    FExpireDate = text_rule_fanLiQty_FExpireDate()
    FIndexCustomerName=text_rule_fanLiQty_FIndexCustomerName()
    FRebateType =text_rule_fanLiQty_FRebateType()

    FStartDate=text_rule_fanLiQty_FStartDate()

    FEndDate=text_rule_fanLiQty_FEndDate()



    mdlGrossProfitAnalysisPkg::rule_fanLiQty_add(token=dms_token,FBillNo =FBillNo ,FCustomerName =FCustomerName ,
                                                 FIndexType = FIndexType,FIndexCustomerName = FIndexCustomerName,FStartRealQty = FStartRealQty,
                                                 FEndRealQty =FEndRealQty ,FUnit = FUnit,FRebateProduct = FRebateProduct,FRebateType = FRebateType,
                                                 FRebateRate =FRebateRate ,FEffectDate =FEffectDate ,FExpireDate = FExpireDate,
                                                 FStartDate=FStartDate,FEndDate=FEndDate
                                                 )
    tsui::pop_notice('添加完成')
    })

  #删除
  shiny::observeEvent(input$btn_rule_fanLiQty_delete,{
    FBillNo = text_rule_fanLiQty_delete()

    mdlGrossProfitAnalysisPkg::rule_fanLiQty_delete(token=dms_token,FBillNo =FBillNo )
    tsui::pop_notice('删除完成')
  })

}
