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
#' grossProfit_managementServer()
grossProfit_managementServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  token=dms_token
  var_text_grossProfit_management_year=tsui::var_text('text_grossProfit_management_year')
  var_text_grossProfit_management_month=tsui::var_text('text_grossProfit_management_month')
  shiny::observeEvent(input$btn_grossProfit_management,{
    if(var_text_grossProfit_management_year()==''){

      tsui::pop_notice("请输入要查询的年份")

    }
    else if(var_text_grossProfit_management_month()==''){
      tsui::pop_notice("请输入要查询的月份")
    }
    else if(var_text_grossProfit_management_year()=='2023' & var_text_grossProfit_management_month()=='11'){
      data=mdlGrossProfitAnalysisPkg::grossProfit_management(token =token )
      tsui::run_dataTable2(id ='grossProfit_management_resultView' ,data =data )
      tsui::run_download_xlsx(id = 'dl_grossProfit_management',data = data,filename = '集团毛利明细表_管理口径.xlsx')
    }
    else
    {
      data=NULL
      tsui::run_dataTable2(id ='grossProfit_management_resultView' ,data =data )
      tsui::run_download_xlsx(id = 'dl_grossProfit_management',data = data,filename = '集团毛利明细表_管理口径.xlsx')


    }


  })
}
