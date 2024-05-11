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
  token=dms_token
  var_text_commision_actual_year=tsui::var_text('text_commision_actual_year')
  var_text_commision_actual_month=tsui::var_text('text_commision_actual_month')
  shiny::observeEvent(input$btn_commision_actual,{
    if(var_text_commision_actual_year()==''){

      tsui::pop_notice("请输入要查询的年份")

    }
    else if(var_text_commision_actual_month()==''){
      tsui::pop_notice("请输入要查询的月份")
    }
    else if(var_text_commision_actual_year()=='2023' & var_text_commision_actual_month()=='11'){
      data=mdlGrossProfitAnalysisPkg::commision_actual(token =token )
      tsui::run_dataTable2(id ='commision_actual_resultView' ,data =data )
      tsui::run_download_xlsx(id = 'dl_commision_actual',data = data,filename = '佣金金额明细表_财务口径.xlsx')
    }
    else
    {
      data=NULL
      tsui::run_dataTable2(id ='commision_actual_resultView' ,data =data )
      tsui::run_download_xlsx(id = 'dl_commision_actual',data = data,filename = '佣金金额明细表_财务口径.xlsx')


    }


  })
}
