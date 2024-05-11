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
#' rebate_actualServer()
rebate_actualServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  var_text_rebate_actual_year=tsui::var_text('text_rebate_actual_year')
  var_text_rebate_actual_month=tsui::var_text('text_rebate_actual_month')


  shiny::observeEvent(input$btn_rebate_actual_selectBydata,{
    mdlGrossProfitAnalysisPkg::rebate_detailQty_actual_deleteBydate(dmstoken =dms_token,year =var_text_rebate_actual_year(),MONTH = var_text_rebate_actual_month() )
    mdlGrossProfitAnalysisPkg::rebate_detailQty_actual_insert(dmstoken =dms_token,year =var_text_rebate_actual_year(),MONTH = var_text_rebate_actual_month()  )

      data=mdlGrossProfitAnalysisPkg::rebate_detailQty_actual_selectBydata(dmstoken =dms_token,year =var_text_rebate_actual_year(),MONTH = var_text_rebate_actual_month()  )
      tsui::run_dataTable2(id ='rebate_actual_resultView' ,data =data )
  })

  shiny::observeEvent(input$btn_rebate_actual_select,{
    data=mdlGrossProfitAnalysisPkg::rebate_detailQty_actual_select(dmstoken =dms_token )
    tsui::run_dataTable2(id ='rebate_actual_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_rebate_actual',data = data,filename = '返利数量明细表.xlsx')



  })
  shiny::observeEvent(input$btn_rebate_actual_delete,{
    mdlGrossProfitAnalysisPkg::rebate_detailQty_actual_delete(dmstoken =dms_token )
    tsui::pop_notice('清除完成')

  })

}
