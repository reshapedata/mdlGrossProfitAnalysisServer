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
#' rule_payment_monthServer()
rule_payment_monthServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  token=dms_token

  text_rule_payment_month_FContractNumber_delete=tsui::var_text('text_rule_payment_month_FContractNumber_delete')
  text_rule_payment_month_FContractNumber=tsui::var_text('text_rule_payment_month_FContractNumber')

  text_rule_payment_month_FSaleOrgName=tsui::var_text('text_rule_payment_month_FSaleOrgName')
  text_rule_payment_month_FCustomerName=tsui::var_text('text_rule_payment_month_FCustomerName')

  text_rule_payment_month_Fyear=tsui::var_text('text_rule_payment_month_Fyear')
  text_rule_payment_month_Fmonth=tsui::var_text('text_rule_payment_month_Fmonth')

  text_rule_payment_month_FPaymentAmount=tsui::var_text('text_rule_payment_month_FPaymentAmount')


  #查询
  shiny::observeEvent(input$btn_rule_payment_month_view,{
    data=mdlGrossProfitAnalysisPkg::rule_payment_month_view(token=dms_token)
    tsui::run_dataTable2(id = 'rule_payment_month_resultView',data=data)

  })
  #添加
  shiny::observeEvent(input$btn_rule_payment_month_add,{
    FContractNumber = text_rule_payment_month_FContractNumber()
    FCustomerName = text_rule_payment_month_FCustomerName()
    Fyear = text_rule_payment_month_Fyear()
    Fmonth = text_rule_payment_month_Fmonth()
    FPaymentAmount=text_rule_payment_month_FPaymentAmount()
    FSaleOrgName=text_rule_payment_month_FSaleOrgName()
    mdlGrossProfitAnalysisPkg::rule_payment_month_add(token=dms_token,FContractNumber =FContractNumber ,
                                                      FSaleOrgName=FSaleOrgName,
                                                      FCustomerName =FCustomerName ,
                                                      Fyear =Fyear ,
                                                      Fmonth = Fmonth,
                                                      FPaymentAmount = FPaymentAmount)
    tsui::pop_notice('添加完成')
  })

  #删除
  shiny::observeEvent(input$btn_rule_payment_month_delete,{
    FContractNumber = text_rule_payment_month_FContractNumber_delete()

    mdlGrossProfitAnalysisPkg::rule_payment_month_delete(token=dms_token,FContractNumber =FContractNumber )
    tsui::pop_notice('删除完成')
  })

}
