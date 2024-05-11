
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
#' ca_returnServer()
ca_returnServer <- function(input,output,session,dms_token,erp_token) {
  #一般按纽,用于计数器显示
  var_text_ca_return_year=tsui::var_text('text_ca_return_year')
  var_text_ca_return_month=tsui::var_text('text_ca_return_month')


  shiny::observeEvent(input$btn_ca_return_select,{

    data=mdlGrossProfitAnalysisPkg::ca_return_select(token = dms_token)
    tsui::run_dataTable2(id ='ca_return_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_ca_return',data = data,filename = '收款单数据.xlsx')



  })
  shiny::observeEvent(input$btn_ca_return_delete,{

    mdlGrossProfitAnalysisPkg::ca_return_delete(token = dms_token)
    tsui::pop_notice('数据已清除')


  })
  shiny::observeEvent(input$btn_ca_return_up,{
    if(var_text_ca_return_year()==''){

      tsui::pop_notice("请输入年份")

    }
    else if(var_text_ca_return_month()==''){
      tsui::pop_notice("请输入月份")
    }
    else
    {
      mdlGrossProfitAnalysisPkg::ca_return_deleteBydata(dmstoken = dms_token,year = var_text_ca_return_year(),MONTH =var_text_ca_return_month() )

      erpdata = mdlGrossProfitAnalysisPkg::REFUNDBILL_jherp_selectBydata(erptoken =erp_token ,year =var_text_ca_return_year() ,MONTH =var_text_ca_return_month() )

      tsda::db_writeTable2(token = dms_token,table_name = 'rds_dms_t_ca_return',r_object = erpdata,append = TRUE)

      tsui::pop_notice('收款退款单数据上传完成')

    }


  })

}
