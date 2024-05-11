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
#' rebate_managementServer()
rebate_managementServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  var_text_rebate_management_year=tsui::var_text('text_rebate_management_year')
  var_text_rebate_management_month=tsui::var_text('text_rebate_management_month')


  shiny::observeEvent(input$btn_rebate_management_selectBydata,{
    mdlGrossProfitAnalysisPkg::fanliQty_mngr_deleteBydate(dmstoken =dms_token,year =var_text_rebate_management_year(),MONTH = var_text_rebate_management_month() )
    mdlGrossProfitAnalysisPkg::fanliQty_mngr_insert(dmstoken =dms_token,year =var_text_rebate_management_year(),MONTH = var_text_rebate_management_month()  )

    data=mdlGrossProfitAnalysisPkg::fanliQty_mngr_selectBydata(dmstoken =dms_token,year =var_text_rebate_management_year(),MONTH = var_text_rebate_management_month()  )
    tsui::run_dataTable2(id ='rebate_management_resultView' ,data =data )
  })

  shiny::observeEvent(input$btn_rebate_management_select,{
    data=mdlGrossProfitAnalysisPkg::fanliQty_mngr_select(dmstoken =dms_token )
    tsui::run_dataTable2(id ='rebate_management_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_rebate_management',data = data,filename = '返利数量明细表_管理口径.xlsx')



  })
  shiny::observeEvent(input$btn_rebate_management_delete,{
    mdlGrossProfitAnalysisPkg::fanliQty_mngr_delete(dmstoken =dms_token )
    tsui::pop_notice('清除完成')

  })

}
