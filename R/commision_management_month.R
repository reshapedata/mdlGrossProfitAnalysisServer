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
#' commision_management_monthServer()
commision_management_monthServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  var_text_commision_management_month_year=tsui::var_text('text_commision_management_month_year')
  var_text_commision_management_month_month=tsui::var_text('text_commision_management_month_month')


  shiny::observeEvent(input$btn_commision_management_month_selectBydata,{

    data=mdlGrossProfitAnalysisPkg::commision_management_month_selectBydata(dmstoken =dms_token,year =var_text_commision_management_month_year(),month = var_text_commision_management_month_month()  )
    tsui::run_dataTable2(id ='commision_management_month_resultView' ,data =data )
  })

  shiny::observeEvent(input$btn_commision_management_month_select,{
    data=mdlGrossProfitAnalysisPkg::commision_management_month_select(dmstoken =dms_token )
    tsui::run_dataTable2(id ='commision_management_month_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_commision_management_month',data = data,filename = '佣金管理口径月度汇总表.xlsx')



  })
  shiny::observeEvent(input$btn_commision_management_month_delete,{
    mdlGrossProfitAnalysisPkg::commision_management_month_delete(dmstoken =dms_token )
    tsui::pop_notice('清除完成')

  })

}
