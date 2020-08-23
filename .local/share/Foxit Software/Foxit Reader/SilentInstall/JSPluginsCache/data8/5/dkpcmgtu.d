   �         9https://1757173384.rsc.cdn77.org/js_plugins/basePlugin.js     %���p      %��THp         
     O K           �      Date   Sun, 31 May 2020 01:55:45 GMT   Content-Type   %application/javascript; charset=utf-8   Last-Modified   Mon, 18 Mar 2019 10:51:18 GMT   Vary   Accept-Encoding   ETag   W/"5c8f7826-6fdb"   Cache-Control   max-age=2628000   Server   CDN77-Turbo   	X-Edge-IP   89.187.173.10   X-Edge-Location   	miamiUSFL   X-Cache   HIT   X-Age   1913537   Content-Encoding   gzip ﻿/**
 * Created by wenqi on 16/11/14.
 * basePlugin
 */
(function () {
    var isWebReader = FX.app.getInfo().appName.toLowerCase() === 'webreader';

    function getCurDoc() {
        var doc = FX.app.getCurDoc();
        return doc ?
            JSON.stringify({
                path: doc.path,
                documentFileName: doc.documentFileName,
                guid: doc.guid,
                isInProtectedViewMode: doc.isInProtectedViewMode || false
            }) : "";
    }

    function readBuf(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        var _this = this;
        return doc.readBuf(param.offset, param.size, function (buf) {
            //FX.app.log('调用doc.readBuf返回成功：' + param.cb);
            try {
                _this.callJScript(param.cb, buf);
            } catch (ex) {
                FX.app.log('callJScript异常');
            }
        })
    }

    function showBalloon(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        var _this = this;
        var balloonID = null;
        var buttons = param.buttons.map(function (button) {
            return {
                'text': button.text,
                'handler': function () {
                    if (button.cb) {
                        _this.callJScript(button.cb);
                        FX.app.log("callJScript in showBalloon");
                    }
                    _this.callJScript("_dispatchEvent", JSON.stringify({
                        'type': "balloonButtonClick",
                        'balloonID': balloonID,
                        'btnId': button.btnId
                    }))
                }
            }
        })
        balloonID = doc.showBalloon(param.title, param.content, buttons, param.id);
        return balloonID;
    }

    function hideBalloon(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.hideBalloon(param.balloonID, param.bExpand ? param.bExpand : false);
    }

    function importAnnotFromXFDF(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        var annot = doc.importAnnotFromXFDF(param.annotXFDF, param.userID, param.bNotify);
        return annot ?
            JSON.stringify({
                name: annot.name,
                type: annot.type,
                guid: annot.guid,
            }) : "";

    }

    function deleteAnnot(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.deleteAnnot(param.pageIndex, param.annotName);
    }

    function getInfo() {
        var info = FX.app.getInfo();
        return JSON.stringify({
            appId: info.appId,
            apiVersion: info.apiVersion,
            appName: info.appName,
            appVersion: info.appVersion,
            baseUrl: info.baseUrl,
            capabilities: info.capabilities ? JSON.parse(info.capabilities) : undefined,
            language: info.language,
            shareUsageData: info.shareUsageData,
            isFipsMode: info.isFipsMode ? info.isFipsMode : false
        })
    }

    function getUserToken() {
        return FX.app.user.getUserToken();
    }

    function getUserId() {
        return FX.app.user.getUserId();
    }

    function getUserEmail() {
        return FX.app.user.getUserEmail();
    }

    function getUserFullName() {
        return FX.app.user.getUserFullName();
    }

    function getUserAvatar() {
        return FX.app.user.getUserAvatar();
    }

    function getDocId(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.getDocId() || "";
    }

    function getCurPageIndex(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.getCurPageIndex();
    }

    function getPageObjNum(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        var result = doc.getPageObjNum(param.pageIndex);
        return result;
    }

    function getPageIndexByPageObjNum(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.getPageIndexByPageObjNum(param.pageObjNum);
    }

    function getPageCount(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.getPageCount();
    }

    function gotoPage(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.gotoPage(param.pageIndex);
    }

    function convertTocPDF(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        var _this = this;
        return doc.convertTocPDF(function () {
            _this.callJScript(param.cb);
            FX.app.log("callJScript in convertTocPDF");
        });
    }

    function writeFile(param) {
        var args = JSON.parse(param);
        var res = FX.localFileStorage.write(args.session, args.key, args.value);
        return res ? res : "";
    }

    function writeFile2(param) {
        var args = JSON.parse(param);
        var res = FX.localFileStorage.write2(args.path, args.mode, args.offset, args.size, args.buf);
        return res ? res : "";
    }

    function readFile(param) {
        var args = JSON.parse(param);
        var result = FX.localFileStorage.read(args.session, args.key);
        return result ? result : "";
    }

    function removeFile(param){
        var args = JSON.parse(param);
        return FX.localFileStorage.remove(args.path, args.session, args.key);
    }

    function writeStorage(param) {
        var args = JSON.parse(param);
        return FX.localStorage.write(args.key, args.value);
    }

    function readStorage(param) {
        var args = JSON.parse(param);
        var result = FX.localStorage.read(args.key);
        return result ? result : "";
    }


    function exportToXFDF(param) {
        param = JSON.parse(param);
        var annot = FX.app.getObject("Annot", param.guid);
        var _this = this;
        annot.exportToXFDF(function (xfdf) {
            _this.callJScript(param.cb, xfdf);
            FX.app.log("callJScript in exportToXFDF");
        })
    }


    function getSubType(param) {
        param = JSON.parse(param);
        var annot = FX.app.getObject("Annot", param.guid);
        return annot.subType;
    }

    function annot_getPageIndex(param) {
        param = JSON.parse(param);
        var annot = FX.app.getObject("Annot", param.guid);
        return annot.pageIndex;
    }

    function getVersionId(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.getVersionID() || "";
    }

    function getEncryptionMethod(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.getEncryptionMethod() || "";
    }

    function getSize(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        var _this = this;
        return doc.getSize(function (size) {
            _this.callJScript(param.cb, '' + size);
            FX.app.log("callJScript in getSize");
        });
    }

    function isForm(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.isForm();
    }

    function isDirty(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.dirty;
    }

    function isCpdf(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.isCpdf();
    }

    function closeDoc(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return FX.app.closeDoc(doc);
    }

    function setReviewType(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.setReviewType(param.isReview);
    }

    function openDoc(path) {
        return FX.app.openDoc(path, true);
    }

    function encryptDocument(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        var encryptionDictInfo = param.encryptionDictInfo;
        var contentKey = param.key;
        var oHandler = param.oHandler;
        var onCreateProtectedDocument = oHandler.onCreateProtectedDocument;
        var _this = this;
        return FX.app.encryptDocument(doc, encryptionDictInfo, contentKey, {
            onCreateProtectedDocument: function (docInfo) {
                if (onCreateProtectedDocument) {
                    _this.callJScript(onCreateProtectedDocument, docInfo);
                }
            }
        });
    }

    function execHtmlDialog(param) {
        var parent = this;
        param = JSON.parse(param);
        var htmlView = FX.app.loadHtmlView(param.url);
        var dialogTemp = null;

        function sendMessageToParent(msg) {
            parent.callJScript("_dispatchEvent", JSON.stringify({
                type: "receiveMessage",
                msg: JSON.parse(msg)
            }));
        }

        function sendMessageToDialog(msg) {
            htmlView.callJScript("_dispatchEvent", JSON.stringify({
                type: "receiveMessage",
                msg: JSON.parse(msg)
            }));
        }

        function closeDialog() {
            dialogTemp.close();
        }
        parent.registerHtmlProxyFunc(sendMessageToDialog, "base", "sendMessage");
        htmlView.registerHtmlProxyFunc(sendMessageToParent, "base", "sendMessage");
        htmlView.registerHtmlProxyFunc(closeDialog, "base", "closeDialog");
        return FX.app.execHtmlDialog({
            sizeX: param.sizeX,
            sizeY: param.sizeY,
            title: param.title,
            htmlView: htmlView,
            initialize: function (dialog) {
                dialogTemp = dialog;
                parent.callJScript(param.initialize);
                FX.app.log("callJScript in initialize")
            },
            destroy: function () {
                parent.callJScript(param.destroy);
                FX.app.log("callJScript in destroy")
            }
        });
    }

    function drmAuthSetKey(param) {
        param = JSON.parse(param);
        var drmAuth = FX.app.getObject("DRMAuth", param.guid);
        return drmAuth.setKey(param.key, param.acl);
    }

    function documentUpdateACL(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.updateACL(JSON.stringify(param.acl));
    }

    function expandPanel() {
        return FX.app.expandPanel(arguments[0] !== 'false');
    }

    function isPanelActivate() {
        return FX.app.isPanelActivate().toString();
    }

    function getDigestId(param) {
        param = JSON.parse(param);
        var path = param.path;
        var cb = param.cb;
        var _this = this;
        if (isWebReader) {
            FX.app.getDigestId(path, function (digestId) {
                _this.callJScript(cb, digestId || '');
            });
        } else {
            var digestId = FX.app.getDigestId(path) || '';
            _this.callJScript(cb, digestId);
        }
    }

    function loginWithUI() {
        return FX.app.loginWithUI();
    }

    function createPin(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.createPin(param.pinId, param.pageObjNum, param.position, param.userId);
    }

    function deletePin(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.deletePin(param.pinId, param.pageObjNum, param.position);
    }

    function activePin(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.activePin(param.pinId, param.pageObjNum, param.position);
    }

    function saveOfflineCopy(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.saveOfflineCopy(JSON.stringify(param.offlineInfo));
    }

    function addAdLayer(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        try {
            return doc.addAdLayer(param.contentText, param.linkText, param.linkUrl);
        } catch (ex) { }
    }


    function removeEncryption(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return FX.app.removeEncryption(doc, param.bUnprotectedCopy);
    }


    function runDocAllEvents() {
        FX.app.runDocAllEvents();
    }

    function setRequestPerm(param) {
        param = JSON.parse(param);
        var drmAuth = FX.app.getObject("DRMAuth", param.guid);
        return drmAuth.setRequestPerm();
    }

    function activateCategory(param) {
        param = JSON.parse(param);
        return FX.app.activateCategory(param.category, param.tip)
    }

    function setHotPoint(bool) {
        return FX.app.setHotPoint(bool === 'true');
    }

    function goToAnnot(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.goToAnnot(param.pageObjNum, param.annotName);
    }

    function opencPDFWebPage(param) {
        try{
            param = JSON.parse(param);
            return FX.app.opencPDFWebPage(param.url, param.title);
        }catch(e){
            return FX.app.opencPDFWebPage(param);
        }
    }

    function appLog(msg) {
        var result = FX.app.log(msg);
        return result;
    }

    function setMobileExtToolButtonProperties(param) {
        return FX.app.setMobileExtToolButtonProperties(JSON.parse(param));
    }

    function showMobileExtToolButtonTips(param) {
		FX.app.log("callJScript in showMobileExtToolButtonTips:" + param)
        return FX.app.showMobileExtToolButtonTips(JSON.parse(param));
    }


    function addFocusedDoc() {
        return FX.app.addFocusedDoc();
    }

    function sendEmail(param) {
        var _this = this;
        param = JSON.parse(param);
        return FX.app.sendEmail(JSON.stringify({
            "toRecipientList": param.toRecipientList,
            "ccRecipientList": param.ccRecipientList,
            "subject": param.subject,
            "message": param.message,
            "attachmentPath": param.attachmentPath,
            "attachmentName": param.attachmentName,
        }),
            function (result) {
                _this.callJScript(param.cb, result);
                FX.app.log("callJScript in sendEmail")
            })
    }

    function addPageOpenJSMessage(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.addPageOpenJSMessage(param.message, param.page);
    }

    function isShowAllPinNote() {
        return FX.app.isShowAllPinNote();
    }

    function showAllPinNote(isShow) {
        FX.app.log("callJScript in showAllPinNote:" + isShow)
        return FX.app.showAllPinNote(isShow === 'true');
    }

    function hoverPin(param) {
        param = JSON.parse(param);
        var doc = FX.app.getObject("Doc", param.guid);
        return doc.hoverPin(param.pinId, JSON.stringify(param.option));
    }

    function signOut() {
        return FX.app.signOut();
    }

    function exportAnonymousAnnot(param) {
        try {
            param = JSON.parse(param);
            var htmlView = this;
            var doc = FX.app.getObject("Doc", param.guid);
            doc.exportAnonymousAnnot(function (annots) {
                var _annots = annots.map(function (annot) {
                    return {
                        name: annot.name,
                        type: annot.type,
                        guid: annot.guid
                    }
                })
                htmlView.callJScript(param.success, JSON.stringify(_annots))
            }, function () {
                htmlView.callJScript(param.fail, "")
            });
        } catch (ex) { return JSON.stringify(ex) }
    }


    function exportAllAnnots(param) {
        try {
            param = JSON.parse(param);
            var htmlView = this;
            var doc = FX.app.getObject("Doc", param.guid);
            doc.exportAllAnnots(function (annots) {
                var _annots = annots.map(function (annot) {
                    return {
                        name: annot.name,
                        type: annot.type,
                        guid: annot.guid
                    }
                })
                htmlView.callJScript(param.success, JSON.stringify(_annots))
            }, function () {
                htmlView.callJScript(param.fail, "")
            });
        } catch (ex) { return JSON.stringify(ex) }
    }

    function saveAsNewcPDF(param){
        try {
            param = JSON.parse(param);
            var htmlView = this;
            var doc = FX.app.getObject("Doc", param.guid);
            // platform webreader can not use FX.app.open(cDocLink) newPath obj type
            doc.saveAsNewcPDF(param.postfix, function(newPath){
                htmlView.callJScript(param.doFinish, newPath);
            })
        } catch (ex) { return JSON.stringify(ex) }
    }


    FX.app.onInitView(function (htmlView) {
        var baseModule = 'base';
        htmlView.registerHtmlProxyFunc(expandPanel, baseModule, "expandPanel");
        htmlView.registerHtmlProxyFunc(writeFile, baseModule, "writeFile");
        htmlView.registerHtmlProxyFunc(writeFile2, baseModule, "writeFile2");
        htmlView.registerHtmlProxyFunc(readFile, baseModule, "readFile");
        htmlView.registerHtmlProxyFunc(writeStorage, baseModule, "writeStorage");
        htmlView.registerHtmlProxyFunc(readStorage, baseModule, "readStorage");
        htmlView.registerHtmlProxyFunc(getDocId, baseModule, "getDocId");
        htmlView.registerHtmlProxyFunc(getCurPageIndex, baseModule, "getCurPageIndex");
        htmlView.registerHtmlProxyFunc(getPageObjNum, baseModule, "getPageObjNum");
        htmlView.registerHtmlProxyFunc(getPageIndexByPageObjNum, baseModule, 'getPageIndexByPageObjNum');
        htmlView.registerHtmlProxyFunc(getUserId, baseModule, "getUserId");
        htmlView.registerHtmlProxyFunc(getUserToken, baseModule, "getUserToken");
        htmlView.registerHtmlProxyFunc(getUserEmail, baseModule, "getUserEmail");
        htmlView.registerHtmlProxyFunc(getUserFullName, baseModule, "getUserFullName");
        htmlView.registerHtmlProxyFunc(getUserAvatar, baseModule, "getUserAvatar");
        htmlView.registerHtmlProxyFunc(getInfo, baseModule, "getInfo");
        htmlView.registerHtmlProxyFunc(getCurDoc, baseModule, "getCurDoc");
        htmlView.registerHtmlProxyFunc(exportToXFDF.bind(htmlView), baseModule, "exportToXFDF");
        htmlView.registerHtmlProxyFunc(deleteAnnot, baseModule, "deleteAnnot");
        htmlView.registerHtmlProxyFunc(readBuf.bind(htmlView), baseModule, "readBuf");
        htmlView.registerHtmlProxyFunc(showBalloon.bind(htmlView), baseModule, "showBalloon");
        htmlView.registerHtmlProxyFunc(hideBalloon, baseModule, "hideBalloon");
        htmlView.registerHtmlProxyFunc(importAnnotFromXFDF, baseModule, "importAnnotFromXFDF");
        htmlView.registerHtmlProxyFunc(getVersionId, baseModule, "getVersionId");
        htmlView.registerHtmlProxyFunc(getEncryptionMethod, baseModule, "getEncryptionMethod");
        htmlView.registerHtmlProxyFunc(getSize.bind(htmlView), baseModule, "getSize");
        htmlView.registerHtmlProxyFunc(closeDoc, baseModule, "closeDoc");
        htmlView.registerHtmlProxyFunc(openDoc, baseModule, "openDoc");
        htmlView.registerHtmlProxyFunc(encryptDocument.bind(htmlView), baseModule, "encryptDocument");
        htmlView.registerHtmlProxyFunc(execHtmlDialog.bind(htmlView), baseModule, "execHtmlDialog");
        htmlView.registerHtmlProxyFunc(convertTocPDF.bind(htmlView), baseModule, "convertTocPDF");
        htmlView.registerHtmlProxyFunc(function () { }, baseModule, "sendMessage");
        htmlView.registerHtmlProxyFunc(drmAuthSetKey, baseModule, "drmAuthSetKey");
        htmlView.registerHtmlProxyFunc(getDigestId.bind(htmlView), baseModule, "getDigestId");
        htmlView.registerHtmlProxyFunc(loginWithUI, baseModule, "loginWithUI");
        htmlView.registerHtmlProxyFunc(isForm, baseModule, "isForm");
        htmlView.registerHtmlProxyFunc(isDirty, baseModule, "isDirty");
        htmlView.registerHtmlProxyFunc(isCpdf, baseModule, "isCpdf");
        htmlView.registerHtmlProxyFunc(createPin, baseModule, "createPin");
        htmlView.registerHtmlProxyFunc(deletePin, baseModule, "deletePin");
        htmlView.registerHtmlProxyFunc(activePin, baseModule, "activePin");
        htmlView.registerHtmlProxyFunc(saveOfflineCopy, baseModule, "saveOfflineCopy");
        htmlView.registerHtmlProxyFunc(removeEncryption, baseModule, "removeEncryption");
        htmlView.registerHtmlProxyFunc(runDocAllEvents, baseModule, "runDocAllEvents");
        htmlView.registerHtmlProxyFunc(isPanelActivate, baseModule, "isPanelActivate");
        htmlView.registerHtmlProxyFunc(setRequestPerm, baseModule, "setRequestPerm");
        htmlView.registerHtmlProxyFunc(activateCategory, baseModule, "activateCategory");
        htmlView.registerHtmlProxyFunc(setHotPoint, baseModule, "setHotPoint");
        htmlView.registerHtmlProxyFunc(goToAnnot, baseModule, "goToAnnot");
        htmlView.registerHtmlProxyFunc(opencPDFWebPage, baseModule, "opencPDFWebPage");
        htmlView.registerHtmlProxyFunc(getPageCount, baseModule, "getPageCount");
        htmlView.registerHtmlProxyFunc(appLog, baseModule, "appLog");
        htmlView.registerHtmlProxyFunc(setMobileExtToolButtonProperties, baseModule, 'setMobileExtToolButtonProperties');
		htmlView.registerHtmlProxyFunc(showMobileExtToolButtonTips, baseModule, 'showMobileExtToolButtonTips');
        htmlView.registerHtmlProxyFunc(setReviewType, baseModule, 'setReviewType');
        htmlView.registerHtmlProxyFunc(getSubType, baseModule, 'getSubType');
        htmlView.registerHtmlProxyFunc(annot_getPageIndex, baseModule, "annot_getPageIndex");
        htmlView.registerHtmlProxyFunc(addFocusedDoc, baseModule, "addFocusedDoc");
        htmlView.registerHtmlProxyFunc(sendEmail, baseModule, 'sendEmail');
        htmlView.registerHtmlProxyFunc(documentUpdateACL, baseModule, "documentUpdateACL");
        htmlView.registerHtmlProxyFunc(addPageOpenJSMessage, baseModule, 'addPageOpenJSMessage');
        htmlView.registerHtmlProxyFunc(isShowAllPinNote, baseModule, 'isShowAllPinNote');
        htmlView.registerHtmlProxyFunc(showAllPinNote, baseModule, 'showAllPinNote');
        htmlView.registerHtmlProxyFunc(hoverPin, baseModule, 'hoverPin');
        htmlView.registerHtmlProxyFunc(addAdLayer, baseModule, 'addAdLayer');
        htmlView.registerHtmlProxyFunc(signOut, baseModule, "signOut");
        htmlView.registerHtmlProxyFunc(gotoPage, baseModule, "gotoPage");
        htmlView.registerHtmlProxyFunc(exportAnonymousAnnot.bind(htmlView), baseModule, "exportAnonymousAnnot");
        htmlView.registerHtmlProxyFunc(exportAllAnnots.bind(htmlView), baseModule, "exportAllAnnots");
        htmlView.registerHtmlProxyFunc(saveAsNewcPDF.bind(htmlView), baseModule, "saveAsNewcPDF");
        htmlView.registerHtmlProxyFunc(removeFile.bind(htmlView), baseModule, "removeFile");
    })

    FX.app.addListener(function () {
        var htmlView = arguments[0];
        var eventType = arguments[1];
        switch (eventType) {
            case "docOpen":
            case "docClose":
                {
                    var doc = arguments[2];
                    htmlView.callJScript("_dispatchEvent", JSON.stringify({
                        type: eventType,
                        doc: {
                            documentFileName: doc.documentFileName,
                            path: doc.path,
                            guid: doc.guid
                        }
                    }))
                }
                break;
            case "annotOnAdd":
            case "annotOnEdit":
            case "annotOnDelete":
            case "annotOnSetFocus":
                {
                    var doc = arguments[2];
                    var annot = arguments[3];
                    htmlView.callJScript("_dispatchEvent", JSON.stringify({
                        type: eventType,
                        doc: {
                            documentFileName: doc.documentFileName,
                            path: doc.path,
                            guid: doc.guid
                        },
                        annot: {
                            name: annot.name,
                            type: annot.type,
                            guid: annot.guid
                        }
                    }))
                }
                break;
            case "userLogin":
            case "userLogout":
                {
                    htmlView.callJScript("_dispatchEvent", JSON.stringify({
                        type: eventType
                    }))
                }
                break;
            case "getDecryptionParams":
                {
                    htmlView.callJScript("_dispatchEvent", JSON.stringify({
                        type: eventType,
                        encryptionDictInfo: JSON.parse(arguments[2]),
                        drmAuth: arguments[3].guid
                    }))
                }
                break;
            case "toolButtonClick":
                {
                    htmlView.callJScript("_dispatchEvent", JSON.stringify({
                        type: eventType,
                        buttonid: arguments[3]
                    }))
                }
                break;
            case "preCreatePin":
            case "activePin":
            case "unActivePin":
            case "deletePin":
            case "movedPin":
            case 'mouseHoverPin':
                {
                    var doc = arguments[2];
                    var pageObjNum = arguments[3];
                    var position = arguments[4];
                    var id = arguments[5];
                    htmlView.callJScript("_dispatchEvent", JSON.stringify({
                        type: eventType,
                        doc: {
                            documentFileName: doc.documentFileName,
                            path: doc.path,
                            guid: doc.guid
                        },
                        pageObjNum: pageObjNum,
                        position: position,
                        id: id
                    }))
                }
                break;
            case 'panelActive':
            case "panelDeactive":
                htmlView.callJScript("_dispatchEvent", JSON.stringify({
                    type: eventType
                }));
                break;
            case 'docChange':
                htmlView.callJScript("_dispatchEvent", JSON.stringify({
                    type: eventType,
                    destPath: arguments[2],
                    docId: arguments[3]
                }));
                break;
            case 'pinsVisibleChanged':
                htmlView.callJScript("_dispatchEvent", JSON.stringify({
                    type: eventType
                }));
                break;
            case 'activeTab':
                htmlView.callJScript("_dispatchEvent", JSON.stringify({
                    type: eventType
                }));
                break;
        }
    })
}())