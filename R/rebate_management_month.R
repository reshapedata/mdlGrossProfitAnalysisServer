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
#' rebate_management_monthServer()
rebate_management_monthServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  var_text_rebate_management_month_year=tsui::var_text('text_rebate_management_month_year')
  var_text_rebate_management_month_month=tsui::var_text('text_rebate_management_month_month')


  shiny::observeEvent(input$btn_rebate_management_month_selectBydata,{

    data=mdlGrossProfitAnalysisPkg::rebate_detailQty_actual_mngr_Bymonth(dmstoken =dms_token,year =var_text_rebate_management_month_year(),MONTH = var_text_rebate_management_month_month()  )
    tsui::run_dataTable2(id ='rebate_management_month_resultView' ,data =data )
  })

  shiny::observeEvent(input$btn_rebate_management_month_select,{
    data=mdlGrossProfitAnalysisPkg::rebate_detailQty_actual_mngr_selectBymonth(dmstoken =dms_token )
    tsui::run_dataTable2(id ='rebate_management_month_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_rebate_management_month',data = data,filename = '返利数量管理口径月度汇总表.xlsx')



  })
  shiny::observeEvent(input$btn_rebate_management_month_delete,{
    mdlGrossProfitAnalysisPkg::rebate_detailQty_actual_mngr_deleteBymonth(dmstoken =dms_token )
    tsui::pop_notice('清除完成')

  })

}
