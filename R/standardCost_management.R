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
#' standardCost_managementServer()
standardCost_managementServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  token=dms_token
  var_text_standardCost_management_year=tsui::var_text('text_standardCost_management_year')
  var_text_standardCost_management_month=tsui::var_text('text_standardCost_management_month')
  shiny::observeEvent(input$btn_standardCost_management,{
    if(var_text_standardCost_management_year()==''){

      tsui::pop_notice("请输入要查询的年份")

    }
    else if(var_text_standardCost_management_month()==''){
      tsui::pop_notice("请输入要查询的月份")
    }
    else if(var_text_standardCost_management_year()=='2023' & var_text_standardCost_management_month()=='11'){
      data=mdlGrossProfitAnalysisPkg::standardCost_management(token =token )
      tsui::run_dataTable2(id ='standardCost_management_resultView' ,data =data )
      tsui::run_download_xlsx(id = 'dl_standardCost_management',data = data,filename = '标准成本明细表_管理口径.xlsx')
    }
    else
    {
      data=NULL
      tsui::run_dataTable2(id ='standardCost_management_resultView' ,data =data )
      tsui::run_download_xlsx(id = 'dl_standardCost_management',data = data,filename = '标准成本明细表_管理口径.xlsx')


    }


  })
}
#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#' @param erp_token
#'
#' @return 返回值
#' @export
#'
#' @examples
#' standardCost_managementServer()
standardCost_managementupdateServer <- function(input,output,session,dms_token,erp_token) {
  #一般按纽,用于计数器显示

  shiny::observeEvent(input$dl_standardCost_management_update,{
    mdlGrossProfitAnalysisPkg::standard_management_delete(dms_token = dms_token)

    mdlGrossProfitAnalysisPkg::standard_management_jherp_insert(erptoken = erp_token,dms_token = dms_token)

    mdlGrossProfitAnalysisPkg::standard_management_update(dms_token = dms_token)

    tsui::pop_notice("更新成功")


  })
}
