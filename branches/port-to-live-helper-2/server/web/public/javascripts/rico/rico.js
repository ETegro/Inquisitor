/**
  *
  *  Copyright 2005 Sabre Airline Solutions
  *
  *  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
  *  file except in compliance with the License. You may obtain a copy of the License at
  *
  *         http://www.apache.org/licenses/LICENSE-2.0
  *
  *  Unless required by applicable law or agreed to in writing, software distributed under the
  *  License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
  *  either express or implied. See the License for the specific language governing permissions
  *  and limitations under the License.
  **/


// This module does NOT depend on prototype.js

var Rico = {
  Version: '2.0 beta2',
  loadRequested: 1,
  loadComplete: 2,
  init : function() {
    try {  // fix IE background image flicker (credit: www.mister-pixel.com)
      document.execCommand("BackgroundImageCache", false, true);
    } catch(err) {}
    this.preloadMsgs='';
    var elements = document.getElementsByTagName('script');
    this.baseHref= location.protocol + "//" + location.host;
    this.loadedFiles={};
    this.loadQueue=[];    
    this.windowIsLoaded=false;
    this.onLoadCallbacks=[];
    for (var i=0; i<elements.length; i++) {
      if (!elements[i].src) continue;
      var src = elements[i].src;
      var slashIdx = src.lastIndexOf('/');
      var path = src.substring(0, slashIdx+1);
      var filename = src.substring(slashIdx+1);
      this.loadedFiles[filename]=this.loadComplete;
      var parmPos  = filename.indexOf('?');
      if (parmPos > 0)
        filename = filename.substring(0, parmPos)
      if (filename == 'rico.js') {
        var isRailsPath = (path.indexOf("/javascripts") > 0)
        if (isRailsPath){
          this.jsDir = "/javascripts/rico/";
          this.cssDir = "/stylesheets/";
          this.imgDir = "/images/";   
          this.htmDir = "/";
          this.xslDir = "/";
        } else {
          this.jsDir = path;
          this.cssDir = path+'css/';
          this.imgDir = path+'images/';
          this.htmDir = path;
          this.xslDir = path;
        }
      }
    }
    if (typeof Prototype=='undefined')
      this.include('prototype.js');
    this.include('ricoCommon.js');
    var func=function() { Rico.windowLoaded(); };
    if (window.addEventListener)
      window.addEventListener('load', func, false);
    else if (window.attachEvent)
      window.attachEvent('onload', func);
    this.onLoad(function() { Rico.writeDebugMsg('Pre-load messages:\n'+Rico.preloadMsgs); });
  },
  
  // Array entries can reference a javascript file or css stylesheet
  // A dependency on another module can be indicated with a plus-sign prefix: '+DependsOnModule'
  moduleDependencies : {
    Accordion  : ['ricoBehaviors.js','ricoEffects.js','ricoComponents.js'],
    Color      : ['ricoColor.js'],
    Corner     : ['ricoStyles.js'],
    DragAndDrop: ['ricoDragDrop.js'],
    Effect     : ['ricoEffects.js'],
    Calendar   : ['ricoCalendar.js', 'ricoCalendar.css'],
    Tree       : ['ricoTree.js', 'ricoTree.css'],
    ColorPicker: ['ricoColorPicker.js', 'ricoStyles.js', 'ricoColorPicker.css'],
    SimpleGrid : ['ricoCommon.js', 'ricoGridCommon.js', 'ricoGrid.css', 'ricoSimpleGrid.js'],
    LiveGrid   : ['ricoCommon.js', 'ricoGridCommon.js', 'ricoGrid.css', 'ricoBehaviors.js', 'ricoLiveGrid.js'],
    CustomMenu : ['ricoMenu.js', 'ricoMenu.css'],
    LiveGridMenu : ['+CustomMenu', 'ricoLiveGridMenu.js'],
    LiveGridAjax : ['+LiveGrid', 'ricoLiveGridAjax.js'],
    LiveGridForms: ['+LiveGridAjax', '+LiveGridMenu', '+Accordion', '+Corner', 'ricoLiveGridForms.js', 'ricoLiveGridForms.css'],
    SpreadSheet  : ['+SimpleGrid', 'ricoSheet.js']
  },
  
  // Expects one or more module or file names
  // not reliable when used with XSLT
  loadModule : function() {
    for (var a=0, length=arguments.length; a<length; a++) {
      var name=arguments[a];
      var dep=this.moduleDependencies[name];
      if (dep) {
        for (var i=0; i<dep.length; i++)
          if (dep[i].substring(0,1)=='+')
            this.loadModule(dep[i].slice(1));
          else
            this.include(dep[i]);
      } else {
        this.include(name);
      }
    }
  },
  
  // not reliable when used with XSLT
  include : function(filename) {
    if (this.loadedFiles[filename]) return;
    this.addPreloadMsg('include: '+filename);
    var ext = filename.substr(filename.lastIndexOf('.')+1);
    switch (ext.toLowerCase()) {
      case 'js':
        this.loadQueue.push(filename);
        this.loadedFiles[filename]=this.loadRequested;
        this.checkLoadQueue();
        return;
      case 'css':
        var el = document.createElement('link');
        el.type = 'text/css';
        el.rel = 'stylesheet'
        el.href = this.cssDir+filename;
        this.loadedFiles[filename]=this.loadComplete;
        document.getElementsByTagName('head')[0].appendChild(el);
        return;
    }
  },
  
  checkLoadQueue: function() {
    if (this.loadQueue.length==0) return;
    if (this.inProcess) return;  // seems to only be required by IE, but applied to all browsers just to be safe
    this.addScriptToDOM(this.loadQueue.shift());
  },
  
  addScriptToDOM: function(filename) {
    this.addPreloadMsg('addScriptToDOM: '+filename);
    var js = document.createElement('script');
    js.type = 'text/javascript';
    js.src = this.jsDir+filename;
    this.loadedFiles[filename]=this.loadRequested;
    this.inProcess=filename;
    var head=document.getElementsByTagName('head')[0];
    if (filename.substring(0,4)=='rico') {
      head.appendChild(js);
    } else if (this.isKonqueror) {
      throw("Cannot load non-Rico js files dynamically in Konqueror");
    } else if(/WebKit|Khtml/i.test(navigator.userAgent)) {
      head.appendChild(js);
      this.includeLoaded(filename);
    } else {
      js.onload = js.onreadystatechange = function() {
        if (js.readyState && js.readyState != 'loaded' && js.readyState != 'complete') return;
        js.onreadystatechange = js.onload = null;
        Rico.includeLoaded(filename);
      };
      head.appendChild(js);
    }
  },
  
  // called after a script file has finished loading
  includeLoaded: function(filename) {
    this.addPreloadMsg('loaded: '+filename);
    this.loadedFiles[filename]=this.loadComplete;
    if (filename==this.inProcess) {
      this.inProcess=null;
      this.checkLoadQueue();
      this.checkIfComplete();
    }
  },

  // called by the document onload event
  windowLoaded: function() {
    this.windowIsLoaded=true;
    this.checkLoadQueue();
    this.checkIfComplete();
  },
  
  checkIfComplete: function() {
    var waitingFor=this.windowIsLoaded ? '' : 'window';
    for(var filename in  this.loadedFiles) {
      if (this.loadedFiles[filename]==this.loadRequested)
        waitingFor+=' '+filename;
    }
    //window.status='waitingFor: '+waitingFor;
    this.addPreloadMsg('waitingFor: '+waitingFor);
    if (waitingFor.length==0) {
      this.addPreloadMsg('Processing callbacks');
      while (this.onLoadCallbacks.length > 0) {
        var callback=this.onLoadCallbacks.pop();
        if (callback) callback();
      }
    }
  },
  
  onLoad: function(callback) {
    this.onLoadCallbacks.push(callback);
    this.checkIfComplete();
  },

  isKonqueror : navigator.userAgent.toLowerCase().indexOf("konqueror") >= 0,

  // logging funtions
   
  startTime : new Date(),

  timeStamp: function() {
    var stamp = new Date();
    return (stamp.getTime()-this.startTime.getTime())+": ";
  },
  
  setDebugArea: function(id, forceit) {
    if (!this.debugArea || forceit) {
      var newarea=document.getElementById(id);
      if (!newarea) return;
      this.debugArea=newarea;
      newarea.value='';
    }
  },

  addPreloadMsg: function(msg) {
    this.preloadMsgs+=Rico.timeStamp()+msg+"\n";
  },

  writeDebugMsg: function(msg, resetFlag) {
    if (this.debugArea) {
      if (resetFlag) this.debugArea.value='';
      this.debugArea.value+=this.timeStamp()+msg+"\n";
    }
  }

}

Rico.init();
