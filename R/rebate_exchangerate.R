
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
#' rebate_exchangerateServer()
rebate_exchangerateServer <- function(input,output,session,dms_token,erp_token) {
  #一般按纽,用于计数器显示
  var_text_rebate_exchangerate_year=tsui::var_text('text_rebate_exchangerate_year')
  var_text_rebate_exchangerate_month=tsui::var_text('text_rebate_exchangerate_month')


  shiny::observeEvent(input$btn_rebate_exchangerate_select,{

    data=mdlGrossProfitAnalysisPkg::rebate_exchangerate_select(token = dms_token)
    tsui::run_dataTable2(id ='rebate_exchangerate_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_rebate_exchangerate',data = data,filename = '汇率体系表.xlsx')


  })
  shiny::observeEvent(input$btn_rebate_exchangerate_delete,{

    mdlGrossProfitAnalysisPkg::rebate_exchangerate_delete(token = dms_token)
    tsui::pop_notice('数据已清除')


  })
  shiny::observeEvent(input$btn_rebate_exchangerate_up,{
    if(var_text_rebate_exchangerate_year()==''){

      tsui::pop_notice("请输入年份")

    }
    else if(var_text_rebate_exchangerate_month()==''){
      tsui::pop_notice("请输入月份")
    }
    else
    {
      mdlGrossProfitAnalysisPkg::exchangerate_deleteBydata(dmstoken = dms_token,year = var_text_rebate_exchangerate_year(),MONTH =var_text_rebate_exchangerate_month() )
      #mdlGrossProfitAnalysisPkg::exchangerate_deleteBydata(dmstoken = dms_token,year = var_text_rebate_exchangerate_year(),MONTH =var_text_rebate_exchangerate_month() )

      erpdata = mdlGrossProfitAnalysisPkg::exchangerate_jherp_selectBydata(erptoken =erp_token ,year =var_text_rebate_exchangerate_year() ,MONTH =var_text_rebate_exchangerate_month() )

      tsda::db_writeTable2(token = dms_token,table_name = 'rds_t_rebate_exchangerate',r_object = erpdata,append = TRUE)

      tsui::pop_notice('汇率体系上传完成')

    }


  })

}
