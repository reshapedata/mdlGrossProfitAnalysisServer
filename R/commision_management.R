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
#' commision_managementServer()
commision_managementServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  token=dms_token
  var_text_commision_management_year=tsui::var_text('text_commision_management_year')
  var_text_commision_management_month=tsui::var_text('text_commision_management_month')
  shiny::observeEvent(input$btn_commision_management,{
    if(var_text_commision_management_year()==''){

      tsui::pop_notice("请输入要查询的年份")

    }
    else if(var_text_commision_management_month()==''){
      tsui::pop_notice("请输入要查询的月份")
    }
    else if(var_text_commision_management_year()=='2023' & var_text_commision_management_month()=='11'){
      data=mdlGrossProfitAnalysisPkg::commision_management(token =token )
      tsui::run_dataTable2(id ='commision_management_resultView' ,data =data )
      tsui::run_download_xlsx(id = 'dl_commision_management',data = data,filename = '佣金金额明细表_管理口径.xlsx')
    }
    else
    {
      data=NULL
      tsui::run_dataTable2(id ='commision_management_resultView' ,data =data )
      tsui::run_download_xlsx(id = 'dl_commision_management',data = data,filename = '佣金金额明细表_管理口径.xlsx')


    }


  })
}
