
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
#' ca_receiveServer()
ca_receiveServer <- function(input,output,session,dms_token,erp_token) {
  #一般按纽,用于计数器显示
  var_text_ca_receive_year=tsui::var_text('text_ca_receive_year')
  var_text_ca_receive_month=tsui::var_text('text_ca_receive_month')


  shiny::observeEvent(input$btn_ca_receive_select,{

    data=mdlGrossProfitAnalysisPkg::ca_receive_select(token = dms_token)
    tsui::run_dataTable2(id ='ca_receive_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_ca_receive',data = data,filename = '收款单数据.xlsx')



  })
  shiny::observeEvent(input$btn_ca_receive_delete,{

    mdlGrossProfitAnalysisPkg::ca_receive_delete(token = dms_token)
    tsui::pop_notice('数据已清除')


  })
  shiny::observeEvent(input$btn_ca_receive_up,{
    if(var_text_ca_receive_year()==''){

      tsui::pop_notice("请输入年份")

    }
    else if(var_text_ca_receive_month()==''){
      tsui::pop_notice("请输入月份")
    }
    else
    {
      mdlGrossProfitAnalysisPkg::ca_receive_deleteBydata(dmstoken = dms_token,year = var_text_ca_receive_year(),MONTH =var_text_ca_receive_month() )

      erpdata = mdlGrossProfitAnalysisPkg::RECEIVEBILL_jherp_selectBydata(erptoken =erp_token ,year =var_text_ca_receive_year() ,MONTH =var_text_ca_receive_month() )

      tsda::db_writeTable2(token = dms_token,table_name = 'rds_dms_t_ca_receive',r_object = erpdata,append = TRUE)

      tsui::pop_notice('收款单数据上传完成')

    }


  })

}
