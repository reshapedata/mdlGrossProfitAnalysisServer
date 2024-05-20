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
#' commision_actualServer()
commision_actualServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  var_text_commision_actual_year=tsui::var_text('text_commision_actual_year')
  var_text_commision_actual_month=tsui::var_text('text_commision_actual_month')


  shiny::observeEvent(input$btn_commision_actual_selectBydata,{
    mdlGrossProfitAnalysisPkg::commision_actual_deleteBydate(dmstoken =dms_token,year =var_text_commision_actual_year(),MONTH = var_text_commision_actual_month() )
    mdlGrossProfitAnalysisPkg::commision_actual_insert(dmstoken =dms_token,year =var_text_commision_actual_year(),MONTH = var_text_commision_actual_month()  )

    data=mdlGrossProfitAnalysisPkg::commision_actual_selectBydata(dmstoken =dms_token,year =var_text_commision_actual_year(),MONTH = var_text_commision_actual_month()  )
    tsui::run_dataTable2(id ='commision_actual_resultView' ,data =data )
  })

  shiny::observeEvent(input$btn_commision_actual_select,{
    data=mdlGrossProfitAnalysisPkg::commision_actual_select(dmstoken =dms_token )
    tsui::run_dataTable2(id ='commision_actual_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_commision_actual',data = data,filename = '佣金财务口径明细表.xlsx')



  })
  shiny::observeEvent(input$btn_commision_actual_delete,{
    mdlGrossProfitAnalysisPkg::commision_actual_delete(dmstoken =dms_token )
    tsui::pop_notice('清除完成')

  })

}
