import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/shimmerservice/shimmerservice_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import 'annual_exam_model.dart';
export 'annual_exam_model.dart';

class AnnualExamWidget extends StatefulWidget {
  const AnnualExamWidget({
    super.key,
    this.serviceid,
    String? choosenservice,
  }) : this.choosenservice = choosenservice ?? 'Test';

  final String? serviceid;
  final String choosenservice;

  @override
  State<AnnualExamWidget> createState() => _AnnualExamWidgetState();
}

class _AnnualExamWidgetState extends State<AnnualExamWidget>
    with TickerProviderStateMixin {
  late AnnualExamModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnnualExamModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'annualExam'});
    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF272727),
              size: 30,
            ),
            onPressed: () async {
              logFirebaseEvent('ANNUAL_EXAM_arrow_back_rounded_ICN_ON_TA');
              logFirebaseEvent('IconButton_navigate_back');
              context.safePop();
            },
          ),
         title: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 20.0),
            child: Text(
              functions.removehyphen(widget.choosenservice),
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Color(0xFF272727),
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          actions: [],
          centerTitle: true,
          toolbarHeight: MediaQuery.sizeOf(context).height * 0.08,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FutureBuilder<ApiCallResponse>(
                  future: SubjectsCall.call(
                    stdId: valueOrDefault<String>(
                      FFAppState().userInfo.stdId,
                      '9',
                    ),
                    userId: valueOrDefault<String>(
                      FFAppState().userInfo.userId,
                      '255735',
                    ),
                    serviceId: valueOrDefault<String>(
                      widget.serviceid,
                      '1',
                    ),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return ShimmerserviceWidget();
                    }
                    final containerSubjectsResponse = snapshot.data!;
                    return Container(
                      height: MediaQuery.sizeOf(context).height * 0.8,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment(0, 0),
                            child: FlutterFlowButtonTabBar(
                              useToggleButtonStyle: true,
                              labelStyle:
                                  FlutterFlowTheme.of(context).titleMedium,
                              unselectedLabelStyle: TextStyle(),
                              labelColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              unselectedLabelColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              backgroundColor:
                                  FlutterFlowTheme.of(context).primary,
                              unselectedBackgroundColor:
                                  FlutterFlowTheme.of(context).alternate,
                              borderColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              unselectedBorderColor:
                                  FlutterFlowTheme.of(context).alternate,
                              borderWidth: 2,
                              borderRadius: 8,
                              elevation: 0,
                              buttonMargin:
                                  EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                              padding: EdgeInsets.all(4),
                              tabs: [
                                Tab(
                                  text: FFLocalizations.of(context).getText(
                                    'ymw2w5bt' /* Round 1 */,
                                  ),
                                ),
                                Tab(
                                  text: FFLocalizations.of(context).getText(
                                    '9fxheure' /* Round 2 */,
                                  ),
                                ),
                              ],
                              controller: _model.tabBarController,
                              onTap: (i) async {
                                [() async {}, () async {}][i]();
                              },
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _model.tabBarController,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 15),
                                  child: Builder(
                                    builder: (context) {
                                       final children = SubjectsCall.productsByservice(
            containerSubjectsResponse.jsonBody,
          )
              ?.where((e) =>
                  functions.jsontostringlist(getJsonField(
                    e,
                    r'''$.round''',
                  )) ==
                  '1')
              .toList()
              ?.toList() ??
          [];
                                      return GridView.builder(
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 12,
                                          childAspectRatio: 0.8,
                                        ),
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: children.length,
                                        itemBuilder: (context, childrenIndex) {
                                          final childrenItem =
                                              children[childrenIndex];
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'ANNUAL_EXAM_Container_6j40vfz3_ON_TAP');
                                               if ((functions.jsontostringlist(
                                                          getJsonField(
                                                        childrenItem,
                                                        r'''$.subject_alias''',
                                                      )) ==
                                                      'Drawing') ||
                                                  (functions.jsontostringlist(
                                                          getJsonField(
                                                        childrenItem,
                                                        r'''$.subject_alias''',
                                                      )) ==
                                                      'Essay')) {
                                                logFirebaseEvent(
                                                    'Container_alert_dialog');
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return WebViewAware(
                                                      child: AlertDialog(
                                                        title: Text('Alert!'),
                                                        content: Text(
                                                            'Tests will be conducted on our website'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext),
                                                            child: Text('Ok'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                logFirebaseEvent(
                                                    'Container_navigate_to');

                                                context.pushNamed(
                                                  'annualExamStart',
                                                  queryParameters: {
                                                    'subjectid': serializeParam(
                                                      getJsonField(
                                                        childrenItem,
                                                        r'''$.subject_id''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                    'serviceid': serializeParam(
                                                      widget.serviceid,
                                                      ParamType.String,
                                                    ),
                                                    'choosensubject':
                                                        serializeParam(
                                                      getJsonField(
                                                        childrenItem,
                                                        r'''$.subject_name''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                    'alias': serializeParam(
                                                      getJsonField(
                                                        childrenItem,
                                                        r'''$.subject_alias''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                    'round': serializeParam(
                                                      '1',
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              }
                                            },
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                   Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 45,
                      decoration: BoxDecoration(
                        color: functions.jsontostringlist(getJsonField(
                                  childrenItem,
                                  r'''$.subscription_status''',
                                )) ==
                                'Subscribed'
                            ? Color(0xFF9868FF)
                            : FlutterFlowTheme.of(context).alternate,
                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      child: Align(
  alignment: AlignmentDirectional(0, 0),
  child: Padding(
    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
    child: Text(
      getJsonField(
        childrenItem,
        r'''$.subscription_status''',
      ).toString(),
      textAlign: TextAlign.center,
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Poppins',
            color: functions.jsontostringlist(getJsonField(
                      childrenItem,
                      r'''$.subscription_status''',
                    )) ==
                    'Subscribed'
                ? FlutterFlowTheme.of(context).alternate
                : FlutterFlowTheme.of(context).secondaryText,
            fontSize: 16,
          ),
    ),
  ),
)
                                                    ),
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.network(
                                                        getJsonField(
                                                          childrenItem,
                                                          r'''$.subject_icon''',
                                                        ).toString(),
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.2,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.15,
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                    context)
                                                                .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              child: Text(
                                                                getJsonField(
                                                                  childrenItem,
                                                                  r'''$.title''',
                                                                ).toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 15),
                                  child: Builder(
                                    builder: (context) {
                                       final children = SubjectsCall
                                                  .productsByservice(
                                            containerSubjectsResponse.jsonBody,
                                          )
                                              ?.where((e) =>
                                                  (SubjectsCall.qaulified(
                                                        containerSubjectsResponse
                                                            .jsonBody,
                                                      )?.contains(getJsonField(
                                                        e,
                                                        r'''$.subject_id''',
                                                      ).toString()) ==
                                                      true) &&
                                                  (functions.jsontostringlist(
                                                          getJsonField(
                                                        e,
                                                        r'''$.round''',
                                                      )) ==
                                                      '2'))
                                              .toList()
                                              ?.toList() ??
                                          [];
                                      return GridView.builder(
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 12,
                                          childAspectRatio: 0.8,
                                        ),
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: children.length,
                                        itemBuilder: (context, childrenIndex) {
                                          final childrenItem =
                                              children[childrenIndex];
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'ANNUAL_EXAM_Container_ttq8bja4_ON_TAP');
                                               if ((functions.jsontostringlist(
                                                          getJsonField(
                                                        childrenItem,
                                                        r'''$.subject_alias''',
                                                      )) ==
                                                      'Drawing') ||
                                                  (functions.jsontostringlist(
                                                          getJsonField(
                                                        childrenItem,
                                                        r'''$.subject_alias''',
                                                      )) ==
                                                      'Essay')) {
                                                logFirebaseEvent(
                                                    'Container_alert_dialog');
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return WebViewAware(
                                                      child: AlertDialog(
                                                        title: Text('Alert!'),
                                                        content: Text(
                                                            'Tests will be conducted on our website'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext),
                                                            child: Text('Ok'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                logFirebaseEvent(
                                                    'Container_navigate_to');

                                                context.pushNamed(
                                                  'annualExamStart',
                                                  queryParameters: {
                                                    'subjectid': serializeParam(
                                                      getJsonField(
                                                        childrenItem,
                                                        r'''$.subject_id''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                    'serviceid': serializeParam(
                                                      widget.serviceid,
                                                      ParamType.String,
                                                    ),
                                                    'choosensubject':
                                                        serializeParam(
                                                      getJsonField(
                                                        childrenItem,
                                                        r'''$.subject_name''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                    'alias': serializeParam(
                                                      getJsonField(
                                                        childrenItem,
                                                        r'''$.subject_alias''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                    'round': serializeParam(
                                                      '2',
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              }
                                            },
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      height: 45.0,
                                                      decoration: BoxDecoration(
                                                        color: functions.jsontostringlist(
                                                                    getJsonField(
                                                                  childrenItem,
                                                                  r'''$.subscription_status''',
                                                                )) ==
                                                                'Subscribed'
                                                            ? Color(0xFF9868FF)
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            getJsonField(
                                                              childrenItem,
                                                              r'''$.subscription_status''',
                                                            ).toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: functions.jsontostringlist(
                                                                              getJsonField(
                                                                            childrenItem,
                                                                            r'''$.subscription_status''',
                                                                          )) ==
                                                                          'Subscribed'
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.network(
                                                        getJsonField(
                                                          childrenItem,
                                                          r'''$.subject_icon''',
                                                        ).toString(),
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.2,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.15,
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                    context)
                                                                .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              child: Text(
                                                                getJsonField(
                                                                  childrenItem,
                                                                  r'''$.title''',
                                                                ).toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Align(
                  alignment: AlignmentDirectional(0, 1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent('ANNUAL_EXAM_PAGE_BUY_NOW_BTN_ON_TAP');
                        logFirebaseEvent('Button_navigate_to');

                        context.pushNamed('productsmenu');
                      },
                      text: FFLocalizations.of(context).getText(
                        'b7cvfov7' /* Buy Now */,
                      ),
                      options: FFButtonOptions(
                        width: 343,
                        height: 48,
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 10)).around(SizedBox(height: 10)),
            ),
          ),
        ),
      ),
    );
  }
}
