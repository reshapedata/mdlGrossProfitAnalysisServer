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
#' rule_commisionAmountServer()
rule_commisionAmountServer <- function(input,output,session,dms_token) {
  #一般按纽,用于计数器显示
  token=dms_token


  text_rule_commisionAmount_Fbillno= tsui::var_text( 'text_rule_commisionAmount_Fbillno')
  text_rule_commisionAmount_FSaleOrgName= tsui::var_text( 'text_rule_commisionAmount_FSaleOrgName')
  text_rule_commisionAmount_FSaleMan=tsui::var_text( 'text_rule_commisionAmount_FSaleMan')
  text_rule_commisionAmount_Fcountry=tsui::var_text( 'text_rule_commisionAmount_Fcountry')
  text_rule_commisionAmount_FStartDate=tsui::var_date('text_rule_commisionAmount_FStartDate')
  text_rule_commisionAmount_FEndDate= tsui::var_date('text_rule_commisionAmount_FEndDate')
  text_rule_commisionAmount_FCustomerName=  tsui::var_text( 'text_rule_commisionAmount_FCustomerName')
  text_rule_commisionAmount_FContidtionName=tsui::var_text( 'text_rule_commisionAmount_FContidtionName')
  text_rule_commisionAmount_FCustMtrlName= tsui::var_text( 'text_rule_commisionAmount_FCustMtrlName')
  text_rule_commisionAmount_FCommisionBy= tsui::var_text( 'text_rule_commisionAmount_FCommisionBy')

  text_rule_commisionAmount_FCommisionStandard= tsui::var_text( 'text_rule_commisionAmount_FCommisionStandard')
  text_rule_commisionAmount_Fcurrency= tsui::var_text( 'text_rule_commisionAmount_Fcurrency')
  text_rule_commisionAmount_FFiscalFee=tsui::var_text( 'text_rule_commisionAmount_FFiscalFee')
  text_rule_commisionAmount_FBillNo_delete=tsui::var_text( 'text_rule_commisionAmount_FBillNo_delete')




  #查询
  shiny::observeEvent(input$btn_rule_commisionAmount_view,{
    data=mdlGrossProfitAnalysisPkg::rule_commisionAmount_view(token=dms_token)
    tsui::run_dataTable2(id = 'rule_commisionAmount_resultView',data=data)

  })
  #添加
  shiny::observeEvent(input$btn_rule_commisionAmount_add,{
    Fbillno =text_rule_commisionAmount_Fbillno()
    FSaleOrgName =text_rule_commisionAmount_FSaleOrgName()
    FSaleMan =text_rule_commisionAmount_FSaleMan()
    Fcountry =text_rule_commisionAmount_Fcountry()
    FStartDate =text_rule_commisionAmount_FStartDate()
    FEndDate =text_rule_commisionAmount_FEndDate()
    FCustomerName =text_rule_commisionAmount_FCustomerName()
    FContidtionName =text_rule_commisionAmount_FContidtionName()
    FCustMtrlName =text_rule_commisionAmount_FCustMtrlName()
    FCommisionBy =text_rule_commisionAmount_FCommisionBy()
    FCommisionStandard=text_rule_commisionAmount_FCommisionStandard()
    Fcurrency =text_rule_commisionAmount_Fcurrency()
    FFiscalFee =text_rule_commisionAmount_FFiscalFee()
      mdlGrossProfitAnalysisPkg::rule_commisionAmount_add(token=dms_token,Fbillno = Fbillno,FSaleOrgName =FSaleOrgName,FSaleMan = FSaleMan,
                           Fcountry =Fcountry ,FStartDate =FStartDate ,FEndDate =FEndDate ,FCustomerName = FCustomerName,FContidtionName =FContidtionName
                           ,FCustMtrlName =FCustMtrlName ,FCommisionBy =FCommisionBy ,FCommisionStandard =FCommisionStandard ,Fcurrency =Fcurrency
                           ,FFiscalFee = FFiscalFee
                                                                      )
    tsui::pop_notice('添加完成')
  })

  #删除
  shiny::observeEvent(input$btn_rule_commisionAmount_delete,{
    FBillNo = text_rule_commisionAmount_FBillNo_delete()
    if (is.null(text_rule_commisionAmount_FBillNo_delete())){

      tsui::pop_notice('请输入单据编号')
    }
    else{


      mdlGrossProfitAnalysisPkg::rule_commisionAmount_delete(token=dms_token,FBillNo =FBillNo )
      tsui::pop_notice('删除完成')
    }

  })

}
