require("rrpg.lua");
local __o_rrpgObjs = require("rrpgObjs.lua");
require("rrpgGUI.lua");
require("rrpgDialogs.lua");
require("rrpgLFM.lua");
require("ndb.lua");

function newfrmTemplate()
    __o_rrpgObjs.beginObjectsLoading();

    local obj = gui.fromHandle(_obj_newObject("form"));
    local self = obj;
    local sheet = nil;

    rawset(obj, "_oldSetNodeObjectFunction", rawget(obj, "setNodeObject"));

    function obj:setNodeObject(nodeObject)
        sheet = nodeObject;
        self.sheet = nodeObject;
        self:_oldSetNodeObjectFunction(nodeObject);
    end;

    function obj:setNodeDatabase(nodeObject)
        self:setNodeObject(nodeObject);
    end;

    _gui_assignInitialParentForForm(obj.handle);
    obj:beginUpdate();
    obj:setName("frmTemplate");
    obj:setFormType("sheetTemplate");
    obj:setDataType("Ambesek.Nefertyne.GURPS");
    obj:setTitle("Ficha GURPS 4E");
    obj:setAlign("client");
    obj:setTheme("dark");

    obj.popDetails = gui.fromHandle(_obj_newObject("popup"));
    obj.popDetails:setParent(obj);
    obj.popDetails:setName("popDetails");
    obj.popDetails:setWidth(250);
    obj.popDetails:setHeight(250);
    obj.popDetails:setBackOpacity(0.4);

    obj.label1 = gui.fromHandle(_obj_newObject("label"));
    obj.label1:setParent(obj.popDetails);
    obj.label1:setAlign("top");
    obj.label1:setField("title");
    obj.label1:setHorzTextAlign("center");
    obj.label1:setName("label1");
    obj.label1:setFontColor("white");

    obj.flowLayout1 = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout1:setParent(obj.popDetails);
    obj.flowLayout1:setAlign("top");
    obj.flowLayout1:setAutoHeight(true);
    obj.flowLayout1:setMaxControlsPerLine(2);
    obj.flowLayout1:setMargins({bottom=4});
    obj.flowLayout1:setHorzAlign("center");
    obj.flowLayout1:setName("flowLayout1");
    obj.flowLayout1:setVertAlign("leading");

    obj.flowPart1 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart1:setParent(obj.flowLayout1);
    obj.flowPart1:setMinWidth(30);
    obj.flowPart1:setMaxWidth(400);
    obj.flowPart1:setHeight(35);
    obj.flowPart1:setName("flowPart1");
    obj.flowPart1:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart1:setVertAlign("leading");

    obj.label2 = gui.fromHandle(_obj_newObject("label"));
    obj.label2:setParent(obj.flowPart1);
    obj.label2:setAlign("top");
    obj.label2:setFontSize(10);
    obj.label2:setText("CUSTO");
    obj.label2:setHorzTextAlign("center");
    obj.label2:setWordWrap(true);
    obj.label2:setTextTrimming("none");
    obj.label2:setAutoSize(true);
    obj.label2:setName("label2");
    obj.label2:setFontColor("#D0D0D0");

    obj.edit1 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit1:setParent(obj.flowPart1);
    obj.edit1:setAlign("client");
    obj.edit1:setField("custo");
    obj.edit1:setHorzTextAlign("center");
    obj.edit1:setFontSize(12);
    obj.edit1:setName("edit1");
    obj.edit1:setFontColor("white");

    obj.textEditor1 = gui.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor1:setParent(obj.popDetails);
    obj.textEditor1:setAlign("client");
    obj.textEditor1:setField("descricao");
    obj.textEditor1:setName("textEditor1");

    obj.dataLink1 = gui.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink1:setParent(obj.popDetails);
    obj.dataLink1:setField("custo");
    obj.dataLink1:setName("dataLink1");


            function pointCount()
                if sheet==nil then return end;

                local pontos = (tonumber(sheet.totalPontos) or 0)
                                - (tonumber(sheet.atributos_st) or 0)
                                - (tonumber(sheet.atributos_ht) or 0)
                                - (tonumber(sheet.atributos_dx) or 0)
                                - (tonumber(sheet.atributos_vt) or 0)
                                - (tonumber(sheet.atributos_iq) or 0)
                                - (tonumber(sheet.atributos_per) or 0)
                                - (tonumber(sheet.atributos_pv) or 0)
                                - (tonumber(sheet.atributos_pf) or 0)
                                - (tonumber(sheet.atributos_velocidade) or 0)
                                - (tonumber(sheet.atributos_deslocamento) or 0)
                                - (tonumber(sheet.vantagens_pontos) or 0)
                                - (tonumber(sheet.desvantagens_pontos) or 0)
                                - (tonumber(sheet.familiaridade_cultural) or 0)
                                - (tonumber(sheet.arquetipo_pontos) or 0)
                                - (tonumber(sheet.idiomas_pontos) or 0);

                local objetos = ndb.getChildNodes(sheet.listaDePericias);
                local custo = 0;
                for i=1, #objetos, 1 do
                    custo = custo + (tonumber(objetos[i].pts) or 0);
                end;
                pontos = pontos - custo;

                local objetos = ndb.getChildNodes(sheet.listaDeTecnicas);
                local custo = 0;
                for i=1, #objetos, 1 do
                    custo = custo + (tonumber(objetos[i].custo) or 0);
                end;
                pontos = pontos - custo;

                local objetos = ndb.getChildNodes(sheet.listaDeMagias);
                local custo = 0;
                for i=1, #objetos, 1 do
                    custo = custo + (tonumber(objetos[i].custo) or 0);
                end;
                pontos = pontos - custo;


                sheet.pontosRestantes = pontos;
            end;
        


    obj.rectangle1 = gui.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle1:setParent(obj);
    obj.rectangle1:setName("rectangle1");
    obj.rectangle1:setAlign("client");
    obj.rectangle1:setColor("#40000000");
    obj.rectangle1:setXradius(10);
    obj.rectangle1:setYradius(10);

    obj.pgcPrincipal = gui.fromHandle(_obj_newObject("tabControl"));
    obj.pgcPrincipal:setParent(obj.rectangle1);
    obj.pgcPrincipal:setAlign("client");
    obj.pgcPrincipal:setName("pgcPrincipal");

    obj.tab1 = gui.fromHandle(_obj_newObject("tab"));
    obj.tab1:setParent(obj.pgcPrincipal);
    obj.tab1:setTitle("Habilidades");
    obj.tab1:setName("tab1");

    obj.rectangle2 = gui.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle2:setParent(obj.tab1);
    obj.rectangle2:setName("rectangle2");
    obj.rectangle2:setAlign("client");
    obj.rectangle2:setColor("#40000000");
    obj.rectangle2:setXradius(10);
    obj.rectangle2:setYradius(10);

    obj.scrollBox1 = gui.fromHandle(_obj_newObject("scrollBox"));
    obj.scrollBox1:setParent(obj.rectangle2);
    obj.scrollBox1:setAlign("client");
    obj.scrollBox1:setName("scrollBox1");

    obj.fraFrenteLayoutNew = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.fraFrenteLayoutNew:setParent(obj.scrollBox1);
    obj.fraFrenteLayoutNew:setAlign("top");
    obj.fraFrenteLayoutNew:setHeight(500);
    obj.fraFrenteLayoutNew:setMargins({left=10, right=10, top=10});
    obj.fraFrenteLayoutNew:setAutoHeight(true);
    obj.fraFrenteLayoutNew:setHorzAlign("center");
    obj.fraFrenteLayoutNew:setLineSpacing(2);
    obj.fraFrenteLayoutNew:setName("fraFrenteLayoutNew");
    obj.fraFrenteLayoutNew:setMaxControlsPerLine(2);
    obj.fraFrenteLayoutNew:setStepSizes({320, 400});
    obj.fraFrenteLayoutNew:setMinScaledWidth(150);
    obj.fraFrenteLayoutNew:setVertAlign("leading");

    obj.flowLayout2 = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout2:setParent(obj.fraFrenteLayoutNew);
    obj.flowLayout2:setAutoHeight(true);
    obj.flowLayout2:setMinScaledWidth(290);
    obj.flowLayout2:setHorzAlign("center");
    obj.flowLayout2:setName("flowLayout2");
    obj.flowLayout2:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout2:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout2:setVertAlign("leading");

    obj.flowLayout3 = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout3:setParent(obj.flowLayout2);
    obj.flowLayout3:setVertAlign("leading");
    obj.flowLayout3:setAutoHeight(true);
    obj.flowLayout3:setMinScaledWidth(290);
    obj.flowLayout3:setMaxControlsPerLine(2);
    obj.flowLayout3:setHorzAlign("center");
    obj.flowLayout3:setLineSpacing(10);
    obj.flowLayout3:setMargins({left=2, top=2, right=16, bottom=4});
    obj.flowLayout3:setAvoidScale(true);
    obj.flowLayout3:setFrameStyle("frames/panel1/frame.xml");
    obj.flowLayout3:setName("flowLayout3");
    obj.flowLayout3:setStepSizes({320, 400});

    obj.flowPart2 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart2:setParent(obj.flowLayout3);
    obj.flowPart2:setStepSizes({130});
    obj.flowPart2:setMinScaledWidth(130);
    obj.flowPart2:setHeight(160);
    obj.flowPart2:setName("flowPart2");
    obj.flowPart2:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart2:setVertAlign("leading");

    obj.edit2 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit2:setParent(obj.flowPart2);
    obj.edit2:setLeft(0);
    obj.edit2:setTop(10);
    obj.edit2:setWidth(40);
    obj.edit2:setHeight(25);
    obj.edit2:setField("atributos_st");
    obj.edit2:setHorzTextAlign("center");
    obj.edit2:setTransparent(true);
    obj.edit2:setName("edit2");
    obj.edit2:setFontSize(15);
    obj.edit2:setFontColor("white");

    obj.label3 = gui.fromHandle(_obj_newObject("label"));
    obj.label3:setParent(obj.flowPart2);
    obj.label3:setLeft(40);
    obj.label3:setTop(10);
    obj.label3:setWidth(50);
    obj.label3:setHeight(25);
    obj.label3:setText("ST");
    obj.label3:setFontSize(10);
    obj.label3:setWordWrap(true);
    obj.label3:setHorzTextAlign("center");
    obj.label3:setTextTrimming("none");
    obj.label3:setName("label3");
    obj.label3:setFontColor("white");

    obj.edit3 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit3:setParent(obj.flowPart2);
    obj.edit3:setLeft(90);
    obj.edit3:setTop(10);
    obj.edit3:setWidth(40);
    obj.edit3:setHeight(25);
    obj.edit3:setField("atributos_mod_st");
    obj.edit3:setHorzTextAlign("center");
    obj.edit3:setTransparent(true);
    obj.edit3:setName("edit3");
    obj.edit3:setFontSize(15);
    obj.edit3:setFontColor("white");

    obj.edit4 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit4:setParent(obj.flowPart2);
    obj.edit4:setLeft(0);
    obj.edit4:setTop(35);
    obj.edit4:setWidth(40);
    obj.edit4:setHeight(25);
    obj.edit4:setField("atributos_dx");
    obj.edit4:setHorzTextAlign("center");
    obj.edit4:setTransparent(true);
    obj.edit4:setName("edit4");
    obj.edit4:setFontSize(15);
    obj.edit4:setFontColor("white");

    obj.label4 = gui.fromHandle(_obj_newObject("label"));
    obj.label4:setParent(obj.flowPart2);
    obj.label4:setLeft(40);
    obj.label4:setTop(35);
    obj.label4:setWidth(50);
    obj.label4:setHeight(25);
    obj.label4:setText("DX");
    obj.label4:setFontSize(10);
    obj.label4:setWordWrap(true);
    obj.label4:setHorzTextAlign("center");
    obj.label4:setTextTrimming("none");
    obj.label4:setName("label4");
    obj.label4:setFontColor("white");

    obj.edit5 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit5:setParent(obj.flowPart2);
    obj.edit5:setLeft(90);
    obj.edit5:setTop(35);
    obj.edit5:setWidth(40);
    obj.edit5:setHeight(25);
    obj.edit5:setField("atributos_mod_dx");
    obj.edit5:setHorzTextAlign("center");
    obj.edit5:setTransparent(true);
    obj.edit5:setName("edit5");
    obj.edit5:setFontSize(15);
    obj.edit5:setFontColor("white");

    obj.edit6 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit6:setParent(obj.flowPart2);
    obj.edit6:setLeft(0);
    obj.edit6:setTop(60);
    obj.edit6:setWidth(40);
    obj.edit6:setHeight(25);
    obj.edit6:setField("atributos_iq");
    obj.edit6:setHorzTextAlign("center");
    obj.edit6:setTransparent(true);
    obj.edit6:setName("edit6");
    obj.edit6:setFontSize(15);
    obj.edit6:setFontColor("white");

    obj.label5 = gui.fromHandle(_obj_newObject("label"));
    obj.label5:setParent(obj.flowPart2);
    obj.label5:setLeft(40);
    obj.label5:setTop(60);
    obj.label5:setWidth(50);
    obj.label5:setHeight(25);
    obj.label5:setText("IQ");
    obj.label5:setFontSize(10);
    obj.label5:setWordWrap(true);
    obj.label5:setHorzTextAlign("center");
    obj.label5:setTextTrimming("none");
    obj.label5:setName("label5");
    obj.label5:setFontColor("white");

    obj.edit7 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit7:setParent(obj.flowPart2);
    obj.edit7:setLeft(90);
    obj.edit7:setTop(60);
    obj.edit7:setWidth(40);
    obj.edit7:setHeight(25);
    obj.edit7:setField("atributos_mod_iq");
    obj.edit7:setHorzTextAlign("center");
    obj.edit7:setTransparent(true);
    obj.edit7:setName("edit7");
    obj.edit7:setFontSize(15);
    obj.edit7:setFontColor("white");

    obj.edit8 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit8:setParent(obj.flowPart2);
    obj.edit8:setLeft(0);
    obj.edit8:setTop(85);
    obj.edit8:setWidth(40);
    obj.edit8:setHeight(25);
    obj.edit8:setField("atributos_ht");
    obj.edit8:setHorzTextAlign("center");
    obj.edit8:setTransparent(true);
    obj.edit8:setName("edit8");
    obj.edit8:setFontSize(15);
    obj.edit8:setFontColor("white");

    obj.label6 = gui.fromHandle(_obj_newObject("label"));
    obj.label6:setParent(obj.flowPart2);
    obj.label6:setLeft(40);
    obj.label6:setTop(85);
    obj.label6:setWidth(50);
    obj.label6:setHeight(25);
    obj.label6:setText("HT");
    obj.label6:setFontSize(10);
    obj.label6:setWordWrap(true);
    obj.label6:setHorzTextAlign("center");
    obj.label6:setTextTrimming("none");
    obj.label6:setName("label6");
    obj.label6:setFontColor("white");

    obj.edit9 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit9:setParent(obj.flowPart2);
    obj.edit9:setLeft(90);
    obj.edit9:setTop(85);
    obj.edit9:setWidth(40);
    obj.edit9:setHeight(25);
    obj.edit9:setField("atributos_mod_ht");
    obj.edit9:setHorzTextAlign("center");
    obj.edit9:setTransparent(true);
    obj.edit9:setName("edit9");
    obj.edit9:setFontSize(15);
    obj.edit9:setFontColor("white");

    obj.edit10 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit10:setParent(obj.flowPart2);
    obj.edit10:setLeft(0);
    obj.edit10:setTop(110);
    obj.edit10:setWidth(40);
    obj.edit10:setHeight(25);
    obj.edit10:setField("atributos_per");
    obj.edit10:setHorzTextAlign("center");
    obj.edit10:setTransparent(true);
    obj.edit10:setName("edit10");
    obj.edit10:setFontSize(15);
    obj.edit10:setFontColor("white");

    obj.label7 = gui.fromHandle(_obj_newObject("label"));
    obj.label7:setParent(obj.flowPart2);
    obj.label7:setLeft(40);
    obj.label7:setTop(110);
    obj.label7:setWidth(50);
    obj.label7:setHeight(25);
    obj.label7:setText("Per");
    obj.label7:setFontSize(10);
    obj.label7:setWordWrap(true);
    obj.label7:setHorzTextAlign("center");
    obj.label7:setTextTrimming("none");
    obj.label7:setName("label7");
    obj.label7:setFontColor("white");

    obj.edit11 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit11:setParent(obj.flowPart2);
    obj.edit11:setLeft(90);
    obj.edit11:setTop(110);
    obj.edit11:setWidth(40);
    obj.edit11:setHeight(25);
    obj.edit11:setField("atributos_mod_per");
    obj.edit11:setHorzTextAlign("center");
    obj.edit11:setTransparent(true);
    obj.edit11:setName("edit11");
    obj.edit11:setFontSize(15);
    obj.edit11:setFontColor("white");

    obj.edit12 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit12:setParent(obj.flowPart2);
    obj.edit12:setLeft(0);
    obj.edit12:setTop(135);
    obj.edit12:setWidth(40);
    obj.edit12:setHeight(25);
    obj.edit12:setField("atributos_vt");
    obj.edit12:setHorzTextAlign("center");
    obj.edit12:setTransparent(true);
    obj.edit12:setName("edit12");
    obj.edit12:setFontSize(15);
    obj.edit12:setFontColor("white");

    obj.label8 = gui.fromHandle(_obj_newObject("label"));
    obj.label8:setParent(obj.flowPart2);
    obj.label8:setLeft(40);
    obj.label8:setTop(135);
    obj.label8:setWidth(50);
    obj.label8:setHeight(25);
    obj.label8:setText("Vont");
    obj.label8:setFontSize(10);
    obj.label8:setWordWrap(true);
    obj.label8:setHorzTextAlign("center");
    obj.label8:setTextTrimming("none");
    obj.label8:setName("label8");
    obj.label8:setFontColor("white");

    obj.edit13 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit13:setParent(obj.flowPart2);
    obj.edit13:setLeft(90);
    obj.edit13:setTop(135);
    obj.edit13:setWidth(40);
    obj.edit13:setHeight(25);
    obj.edit13:setField("atributos_mod_vt");
    obj.edit13:setHorzTextAlign("center");
    obj.edit13:setTransparent(true);
    obj.edit13:setName("edit13");
    obj.edit13:setFontSize(15);
    obj.edit13:setFontColor("white");

    obj.flowPart3 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart3:setParent(obj.flowLayout3);
    obj.flowPart3:setStepSizes({130});
    obj.flowPart3:setMinScaledWidth(130);
    obj.flowPart3:setHeight(160);
    obj.flowPart3:setName("flowPart3");
    obj.flowPart3:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart3:setVertAlign("leading");

    obj.edit14 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit14:setParent(obj.flowPart3);
    obj.edit14:setLeft(0);
    obj.edit14:setTop(10);
    obj.edit14:setWidth(40);
    obj.edit14:setHeight(25);
    obj.edit14:setField("atributos_deslocamento");
    obj.edit14:setHorzTextAlign("center");
    obj.edit14:setTransparent(true);
    obj.edit14:setName("edit14");
    obj.edit14:setFontSize(15);
    obj.edit14:setFontColor("white");

    obj.label9 = gui.fromHandle(_obj_newObject("label"));
    obj.label9:setParent(obj.flowPart3);
    obj.label9:setLeft(40);
    obj.label9:setTop(10);
    obj.label9:setWidth(50);
    obj.label9:setHeight(25);
    obj.label9:setText("Desloc.");
    obj.label9:setFontSize(10);
    obj.label9:setWordWrap(true);
    obj.label9:setHorzTextAlign("center");
    obj.label9:setTextTrimming("none");
    obj.label9:setName("label9");
    obj.label9:setFontColor("white");

    obj.edit15 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit15:setParent(obj.flowPart3);
    obj.edit15:setLeft(90);
    obj.edit15:setTop(10);
    obj.edit15:setWidth(40);
    obj.edit15:setHeight(25);
    obj.edit15:setField("atributos_mod_deslocamento");
    obj.edit15:setHorzTextAlign("center");
    obj.edit15:setTransparent(true);
    obj.edit15:setName("edit15");
    obj.edit15:setFontSize(15);
    obj.edit15:setFontColor("white");

    obj.label10 = gui.fromHandle(_obj_newObject("label"));
    obj.label10:setParent(obj.flowPart3);
    obj.label10:setLeft(40);
    obj.label10:setTop(35);
    obj.label10:setWidth(50);
    obj.label10:setHeight(25);
    obj.label10:setText("Esquiva");
    obj.label10:setFontSize(10);
    obj.label10:setWordWrap(true);
    obj.label10:setHorzTextAlign("center");
    obj.label10:setTextTrimming("none");
    obj.label10:setName("label10");
    obj.label10:setFontColor("white");

    obj.label11 = gui.fromHandle(_obj_newObject("label"));
    obj.label11:setParent(obj.flowPart3);
    obj.label11:setLeft(90);
    obj.label11:setTop(35);
    obj.label11:setWidth(40);
    obj.label11:setHeight(25);
    obj.label11:setField("dodge");
    obj.label11:setHorzTextAlign("center");
    obj.label11:setName("label11");
    obj.label11:setFontColor("white");

    obj.dataLink2 = gui.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink2:setParent(obj.flowPart3);
    obj.dataLink2:setField("atributos_mod_velocidade");
    obj.dataLink2:setName("dataLink2");

    obj.edit16 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit16:setParent(obj.flowPart3);
    obj.edit16:setLeft(0);
    obj.edit16:setTop(60);
    obj.edit16:setWidth(40);
    obj.edit16:setHeight(25);
    obj.edit16:setField("atributos_velocidade");
    obj.edit16:setHorzTextAlign("center");
    obj.edit16:setTransparent(true);
    obj.edit16:setName("edit16");
    obj.edit16:setFontSize(15);
    obj.edit16:setFontColor("white");

    obj.label12 = gui.fromHandle(_obj_newObject("label"));
    obj.label12:setParent(obj.flowPart3);
    obj.label12:setLeft(40);
    obj.label12:setTop(60);
    obj.label12:setWidth(50);
    obj.label12:setHeight(25);
    obj.label12:setText("Velocidade");
    obj.label12:setFontSize(10);
    obj.label12:setWordWrap(true);
    obj.label12:setHorzTextAlign("center");
    obj.label12:setTextTrimming("none");
    obj.label12:setName("label12");
    obj.label12:setFontColor("white");

    obj.edit17 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit17:setParent(obj.flowPart3);
    obj.edit17:setLeft(90);
    obj.edit17:setTop(60);
    obj.edit17:setWidth(40);
    obj.edit17:setHeight(25);
    obj.edit17:setField("atributos_mod_velocidade");
    obj.edit17:setType("float");
    obj.edit17:setHorzTextAlign("center");
    obj.edit17:setTransparent(true);
    obj.edit17:setName("edit17");
    obj.edit17:setFontSize(15);
    obj.edit17:setFontColor("white");

    obj.label13 = gui.fromHandle(_obj_newObject("label"));
    obj.label13:setParent(obj.flowPart3);
    obj.label13:setLeft(40);
    obj.label13:setTop(85);
    obj.label13:setWidth(50);
    obj.label13:setHeight(25);
    obj.label13:setText("Carga Base");
    obj.label13:setFontSize(10);
    obj.label13:setWordWrap(true);
    obj.label13:setHorzTextAlign("center");
    obj.label13:setTextTrimming("none");
    obj.label13:setName("label13");
    obj.label13:setFontColor("white");

    obj.edit18 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit18:setParent(obj.flowPart3);
    obj.edit18:setLeft(90);
    obj.edit18:setTop(85);
    obj.edit18:setWidth(40);
    obj.edit18:setHeight(25);
    obj.edit18:setField("carga");
    obj.edit18:setHorzTextAlign("center");
    obj.edit18:setTransparent(true);
    obj.edit18:setName("edit18");
    obj.edit18:setFontSize(15);
    obj.edit18:setFontColor("white");

    obj.label14 = gui.fromHandle(_obj_newObject("label"));
    obj.label14:setParent(obj.flowPart3);
    obj.label14:setLeft(40);
    obj.label14:setTop(110);
    obj.label14:setWidth(50);
    obj.label14:setHeight(25);
    obj.label14:setText("GdP");
    obj.label14:setFontSize(10);
    obj.label14:setWordWrap(true);
    obj.label14:setHorzTextAlign("center");
    obj.label14:setTextTrimming("none");
    obj.label14:setName("label14");
    obj.label14:setFontColor("white");

    obj.edit19 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit19:setParent(obj.flowPart3);
    obj.edit19:setLeft(90);
    obj.edit19:setTop(110);
    obj.edit19:setWidth(40);
    obj.edit19:setHeight(25);
    obj.edit19:setField("gdp");
    obj.edit19:setHorzTextAlign("center");
    obj.edit19:setTransparent(true);
    obj.edit19:setName("edit19");
    obj.edit19:setFontSize(15);
    obj.edit19:setFontColor("white");

    obj.label15 = gui.fromHandle(_obj_newObject("label"));
    obj.label15:setParent(obj.flowPart3);
    obj.label15:setLeft(40);
    obj.label15:setTop(135);
    obj.label15:setWidth(50);
    obj.label15:setHeight(25);
    obj.label15:setText("GdB");
    obj.label15:setFontSize(10);
    obj.label15:setWordWrap(true);
    obj.label15:setHorzTextAlign("center");
    obj.label15:setTextTrimming("none");
    obj.label15:setName("label15");
    obj.label15:setFontColor("white");

    obj.edit20 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit20:setParent(obj.flowPart3);
    obj.edit20:setLeft(90);
    obj.edit20:setTop(135);
    obj.edit20:setWidth(40);
    obj.edit20:setHeight(25);
    obj.edit20:setField("gdb");
    obj.edit20:setHorzTextAlign("center");
    obj.edit20:setTransparent(true);
    obj.edit20:setName("edit20");
    obj.edit20:setFontSize(15);
    obj.edit20:setFontColor("white");

    obj.dataLink3 = gui.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink3:setParent(obj.flowLayout2);
    obj.dataLink3:setFields({'atributos_st','atributos_ht','atributos_dx','atributos_vt','atributos_iq','atributos_per','atributos_velocidade','atributos_deslocamento'});
    obj.dataLink3:setDefaultValues({'+0','+0','+0','+0','+0','+0','+0','+0'});
    obj.dataLink3:setName("dataLink3");

    obj.dataLink4 = gui.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink4:setParent(obj.flowLayout2);
    obj.dataLink4:setFields({'atributos_mod_st','atributos_mod_dx','atributos_mod_iq','atributos_mod_ht','atributos_mod_vt','atributos_mod_per'});
    obj.dataLink4:setDefaultValues({10,10,10,10,10,10});
    obj.dataLink4:setName("dataLink4");

    obj.flowLineBreak1 = gui.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak1:setParent(obj.flowLayout2);
    obj.flowLineBreak1:setName("flowLineBreak1");

    obj.flowLayout4 = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout4:setParent(obj.flowLayout2);
    obj.flowLayout4:setVertAlign("leading");
    obj.flowLayout4:setAutoHeight(true);
    obj.flowLayout4:setMinScaledWidth(290);
    obj.flowLayout4:setMaxControlsPerLine(2);
    obj.flowLayout4:setHorzAlign("center");
    obj.flowLayout4:setLineSpacing(10);
    obj.flowLayout4:setMargins({left=2, top=2, right=16, bottom=4});
    obj.flowLayout4:setAvoidScale(true);
    obj.flowLayout4:setName("flowLayout4");
    obj.flowLayout4:setStepSizes({320, 400});

    obj.flowPart4 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart4:setParent(obj.flowLayout4);
    obj.flowPart4:setHeight(140);
    obj.flowPart4:setMinWidth(120);
    obj.flowPart4:setMaxWidth(120);
    obj.flowPart4:setMinScaledWidth(120);
    obj.flowPart4:setFrameStyle("frames/atributeFrame/frame.xml");
    obj.flowPart4:setName("flowPart4");
    obj.flowPart4:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart4:setVertAlign("leading");

    obj.layout1 = gui.fromHandle(_obj_newObject("layout"));
    obj.layout1:setParent(obj.flowPart4);
    obj.layout1:setLeft(6);
    obj.layout1:setTop(12);
    obj.layout1:setWidth(116);
    obj.layout1:setHeight(115);
    obj.layout1:setName("layout1");

    obj.edit21 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit21:setParent(obj.layout1);
    obj.edit21:setAlign("top");
    obj.edit21:setMargins({left=25, right=30});
    obj.edit21:setField("atributos_pv");
    obj.edit21:setHeight(30);
    obj.edit21:setType("number");
    obj.edit21:setHorzTextAlign("center");
    obj.edit21:setVertTextAlign("center");
    obj.edit21:setName("edit21");
    obj.edit21:setTransparent(true);
    obj.edit21:setFontSize(15);
    obj.edit21:setFontColor("white");

    obj.edit22 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit22:setParent(obj.flowPart4);
    obj.edit22:setFrameRegion("modificador");
    obj.edit22:setField("atributos_mod_pv");
    obj.edit22:setHorzTextAlign("center");
    obj.edit22:setVertTextAlign("center");
    obj.edit22:setFontSize(46);
    lfm_setPropAsString(obj.edit22, "fontStyle",  "bold");
    obj.edit22:setTransparent(true);
    obj.edit22:setMin(3);
    obj.edit22:setName("edit22");
    obj.edit22:setFontColor("white");

    obj.label16 = gui.fromHandle(_obj_newObject("label"));
    obj.label16:setParent(obj.flowPart4);
    obj.label16:setFrameRegion("titulo");
    obj.label16:setText("PV");
    obj.label16:setVertTextAlign("center");
    obj.label16:setHorzTextAlign("center");
    obj.label16:setName("label16");
    obj.label16:setFontColor("white");

    obj.flowPart5 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart5:setParent(obj.flowLayout4);
    obj.flowPart5:setHeight(140);
    obj.flowPart5:setMinWidth(120);
    obj.flowPart5:setMaxWidth(120);
    obj.flowPart5:setMinScaledWidth(120);
    obj.flowPart5:setFrameStyle("frames/atributeFrame/frame.xml");
    obj.flowPart5:setName("flowPart5");
    obj.flowPart5:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart5:setVertAlign("leading");

    obj.layout2 = gui.fromHandle(_obj_newObject("layout"));
    obj.layout2:setParent(obj.flowPart5);
    obj.layout2:setLeft(6);
    obj.layout2:setTop(12);
    obj.layout2:setWidth(116);
    obj.layout2:setHeight(115);
    obj.layout2:setName("layout2");

    obj.edit23 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit23:setParent(obj.layout2);
    obj.edit23:setAlign("top");
    obj.edit23:setMargins({left=25, right=30});
    obj.edit23:setField("atributos_pf");
    obj.edit23:setHeight(30);
    obj.edit23:setType("number");
    obj.edit23:setHorzTextAlign("center");
    obj.edit23:setVertTextAlign("center");
    obj.edit23:setName("edit23");
    obj.edit23:setTransparent(true);
    obj.edit23:setFontSize(15);
    obj.edit23:setFontColor("white");

    obj.edit24 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit24:setParent(obj.flowPart5);
    obj.edit24:setFrameRegion("modificador");
    obj.edit24:setField("atributos_mod_pf");
    obj.edit24:setHorzTextAlign("center");
    obj.edit24:setVertTextAlign("center");
    obj.edit24:setFontSize(46);
    lfm_setPropAsString(obj.edit24, "fontStyle",  "bold");
    obj.edit24:setTransparent(true);
    obj.edit24:setMin(3);
    obj.edit24:setName("edit24");
    obj.edit24:setFontColor("white");

    obj.label17 = gui.fromHandle(_obj_newObject("label"));
    obj.label17:setParent(obj.flowPart5);
    obj.label17:setFrameRegion("titulo");
    obj.label17:setText("PF");
    obj.label17:setVertTextAlign("center");
    obj.label17:setHorzTextAlign("center");
    obj.label17:setName("label17");
    obj.label17:setFontColor("white");

    obj.flowLineBreak2 = gui.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak2:setParent(obj.flowLayout2);
    obj.flowLineBreak2:setName("flowLineBreak2");

    obj.button1 = gui.fromHandle(_obj_newObject("button"));
    obj.button1:setParent(obj.flowLayout2);
    obj.button1:setMargins({top=5,bottom=5});
    obj.button1:setAlign("top");
    obj.button1:setText("Arquétipo");
    obj.button1:setWidth(250);
    obj.button1:setName("button1");

    obj.flowLineBreak3 = gui.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak3:setParent(obj.flowLayout2);
    obj.flowLineBreak3:setName("flowLineBreak3");

    obj.button2 = gui.fromHandle(_obj_newObject("button"));
    obj.button2:setParent(obj.flowLayout2);
    obj.button2:setMargins({top=5,bottom=5});
    obj.button2:setAlign("top");
    obj.button2:setText("Vantagens");
    obj.button2:setWidth(250);
    obj.button2:setName("button2");

    obj.flowLineBreak4 = gui.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak4:setParent(obj.flowLayout2);
    obj.flowLineBreak4:setName("flowLineBreak4");

    obj.button3 = gui.fromHandle(_obj_newObject("button"));
    obj.button3:setParent(obj.flowLayout2);
    obj.button3:setMargins({top=5,bottom=5});
    obj.button3:setAlign("top");
    obj.button3:setText("Desvantagens");
    obj.button3:setWidth(250);
    obj.button3:setName("button3");

    obj.flowLineBreak5 = gui.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak5:setParent(obj.flowLayout2);
    obj.flowLineBreak5:setName("flowLineBreak5");

    obj.button4 = gui.fromHandle(_obj_newObject("button"));
    obj.button4:setParent(obj.flowLayout2);
    obj.button4:setMargins({top=5,bottom=5});
    obj.button4:setAlign("top");
    obj.button4:setText("Familiaridades Culturais");
    obj.button4:setWidth(250);
    obj.button4:setName("button4");

    obj.flowLineBreak6 = gui.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak6:setParent(obj.flowLayout2);
    obj.flowLineBreak6:setName("flowLineBreak6");

    obj.button5 = gui.fromHandle(_obj_newObject("button"));
    obj.button5:setParent(obj.flowLayout2);
    obj.button5:setMargins({top=5,bottom=5});
    obj.button5:setAlign("top");
    obj.button5:setText("Idiomas");
    obj.button5:setWidth(250);
    obj.button5:setName("button5");

    obj.dataLink5 = gui.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink5:setParent(obj.flowLayout2);
    obj.dataLink5:setFields({'vantagens_pontos', 'desvantagens_pontos', 'familiaridade_cultural','arquetipo_pontos','idiomas_pontos'});
    obj.dataLink5:setName("dataLink5");

    obj.flowLineBreak7 = gui.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak7:setParent(obj.flowLayout2);
    obj.flowLineBreak7:setName("flowLineBreak7");

    obj.flowPart6 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart6:setParent(obj.flowLayout2);
    obj.flowPart6:setStepSizes({120});
    obj.flowPart6:setMinScaledWidth(120);
    obj.flowPart6:setMargins({top=5});
    obj.flowPart6:setHeight(145);
    obj.flowPart6:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart6:setName("flowPart6");
    obj.flowPart6:setVertAlign("leading");

    obj.label18 = gui.fromHandle(_obj_newObject("label"));
    obj.label18:setParent(obj.flowPart6);
    obj.label18:setLeft(15);
    obj.label18:setTop(10);
    obj.label18:setWidth(90);
    obj.label18:setHeight(25);
    obj.label18:setField("bc_0");
    obj.label18:setFontSize(10);
    obj.label18:setWordWrap(true);
    obj.label18:setHorzTextAlign("center");
    obj.label18:setTextTrimming("none");
    obj.label18:setName("label18");
    obj.label18:setFontColor("white");

    obj.label19 = gui.fromHandle(_obj_newObject("label"));
    obj.label19:setParent(obj.flowPart6);
    obj.label19:setLeft(15);
    obj.label19:setTop(35);
    obj.label19:setWidth(90);
    obj.label19:setHeight(25);
    obj.label19:setField("bc_1");
    obj.label19:setFontSize(10);
    obj.label19:setWordWrap(true);
    obj.label19:setHorzTextAlign("center");
    obj.label19:setTextTrimming("none");
    obj.label19:setName("label19");
    obj.label19:setFontColor("white");

    obj.label20 = gui.fromHandle(_obj_newObject("label"));
    obj.label20:setParent(obj.flowPart6);
    obj.label20:setLeft(15);
    obj.label20:setTop(60);
    obj.label20:setWidth(90);
    obj.label20:setHeight(25);
    obj.label20:setField("bc_2");
    obj.label20:setFontSize(10);
    obj.label20:setWordWrap(true);
    obj.label20:setHorzTextAlign("center");
    obj.label20:setTextTrimming("none");
    obj.label20:setName("label20");
    obj.label20:setFontColor("white");

    obj.label21 = gui.fromHandle(_obj_newObject("label"));
    obj.label21:setParent(obj.flowPart6);
    obj.label21:setLeft(15);
    obj.label21:setTop(85);
    obj.label21:setWidth(90);
    obj.label21:setHeight(25);
    obj.label21:setField("bc_3");
    obj.label21:setFontSize(10);
    obj.label21:setWordWrap(true);
    obj.label21:setHorzTextAlign("center");
    obj.label21:setTextTrimming("none");
    obj.label21:setName("label21");
    obj.label21:setFontColor("white");

    obj.label22 = gui.fromHandle(_obj_newObject("label"));
    obj.label22:setParent(obj.flowPart6);
    obj.label22:setLeft(15);
    obj.label22:setTop(110);
    obj.label22:setWidth(90);
    obj.label22:setHeight(25);
    obj.label22:setField("bc_4");
    obj.label22:setFontSize(10);
    obj.label22:setWordWrap(true);
    obj.label22:setHorzTextAlign("center");
    obj.label22:setTextTrimming("none");
    obj.label22:setName("label22");
    obj.label22:setFontColor("white");

    obj.dataLink6 = gui.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink6:setParent(obj.flowLayout2);
    obj.dataLink6:setField("carga");
    obj.dataLink6:setName("dataLink6");

    obj.flowPart7 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart7:setParent(obj.flowLayout2);
    obj.flowPart7:setStepSizes({120});
    obj.flowPart7:setMinScaledWidth(120);
    obj.flowPart7:setMargins({top=5});
    obj.flowPart7:setHeight(145);
    obj.flowPart7:setFrameStyle("frames/panel4transp/frame.xml");
    obj.flowPart7:setName("flowPart7");
    obj.flowPart7:setVertAlign("leading");

    obj.label23 = gui.fromHandle(_obj_newObject("label"));
    obj.label23:setParent(obj.flowPart7);
    obj.label23:setLeft(15);
    obj.label23:setTop(10);
    obj.label23:setWidth(90);
    obj.label23:setHeight(25);
    obj.label23:setField("db_0");
    obj.label23:setFontSize(10);
    obj.label23:setWordWrap(true);
    obj.label23:setHorzTextAlign("center");
    obj.label23:setTextTrimming("none");
    obj.label23:setName("label23");
    obj.label23:setFontColor("white");

    obj.label24 = gui.fromHandle(_obj_newObject("label"));
    obj.label24:setParent(obj.flowPart7);
    obj.label24:setLeft(15);
    obj.label24:setTop(35);
    obj.label24:setWidth(90);
    obj.label24:setHeight(25);
    obj.label24:setField("db_1");
    obj.label24:setFontSize(10);
    obj.label24:setWordWrap(true);
    obj.label24:setHorzTextAlign("center");
    obj.label24:setTextTrimming("none");
    obj.label24:setName("label24");
    obj.label24:setFontColor("white");

    obj.label25 = gui.fromHandle(_obj_newObject("label"));
    obj.label25:setParent(obj.flowPart7);
    obj.label25:setLeft(15);
    obj.label25:setTop(60);
    obj.label25:setWidth(90);
    obj.label25:setHeight(25);
    obj.label25:setField("db_2");
    obj.label25:setFontSize(10);
    obj.label25:setWordWrap(true);
    obj.label25:setHorzTextAlign("center");
    obj.label25:setTextTrimming("none");
    obj.label25:setName("label25");
    obj.label25:setFontColor("white");

    obj.label26 = gui.fromHandle(_obj_newObject("label"));
    obj.label26:setParent(obj.flowPart7);
    obj.label26:setLeft(15);
    obj.label26:setTop(85);
    obj.label26:setWidth(90);
    obj.label26:setHeight(25);
    obj.label26:setField("db_3");
    obj.label26:setFontSize(10);
    obj.label26:setWordWrap(true);
    obj.label26:setHorzTextAlign("center");
    obj.label26:setTextTrimming("none");
    obj.label26:setName("label26");
    obj.label26:setFontColor("white");

    obj.label27 = gui.fromHandle(_obj_newObject("label"));
    obj.label27:setParent(obj.flowPart7);
    obj.label27:setLeft(15);
    obj.label27:setTop(110);
    obj.label27:setWidth(90);
    obj.label27:setHeight(25);
    obj.label27:setField("db_4");
    obj.label27:setFontSize(10);
    obj.label27:setWordWrap(true);
    obj.label27:setHorzTextAlign("center");
    obj.label27:setTextTrimming("none");
    obj.label27:setName("label27");
    obj.label27:setFontColor("white");

    obj.dataLink7 = gui.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink7:setParent(obj.flowLayout2);
    obj.dataLink7:setField("atributos_mod_velocidade");
    obj.dataLink7:setName("dataLink7");

    obj.flowLineBreak8 = gui.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak8:setParent(obj.flowLayout2);
    obj.flowLineBreak8:setName("flowLineBreak8");

    obj.flowPart8 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart8:setParent(obj.flowLayout2);
    obj.flowPart8:setMinWidth(280);
    obj.flowPart8:setMaxWidth(800);
    obj.flowPart8:setMargins({top=10});
    obj.flowPart8:setHeight(64);
    obj.flowPart8:setFrameStyle("frames/posCaptionEdit1/frame.xml");
    obj.flowPart8:setName("flowPart8");
    obj.flowPart8:setVertAlign("leading");

    obj.edit25 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit25:setParent(obj.flowPart8);
    obj.edit25:setAlign("left");
    obj.edit25:setField("nt_total");
    obj.edit25:setWidth(65);
    obj.edit25:setName("edit25");
    obj.edit25:setTransparent(true);
    obj.edit25:setVertTextAlign("center");
    obj.edit25:setHorzTextAlign("center");
    obj.edit25:setFontSize(15);
    obj.edit25:setFontColor("white");

    obj.label28 = gui.fromHandle(_obj_newObject("label"));
    obj.label28:setParent(obj.flowPart8);
    obj.label28:setAlign("client");
    obj.label28:setText("Nível Tecnológico");
    obj.label28:setMargins({left=10});
    obj.label28:setHorzTextAlign("center");
    obj.label28:setName("label28");
    obj.label28:setFontSize(12);
    obj.label28:setFontColor("#D0D0D0");

    obj.flowLayout5 = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout5:setParent(obj.fraFrenteLayoutNew);
    obj.flowLayout5:setAutoHeight(true);
    obj.flowLayout5:setMinScaledWidth(290);
    obj.flowLayout5:setHorzAlign("center");
    obj.flowLayout5:setName("flowLayout5");
    obj.flowLayout5:setStepSizes({310, 420, 640, 760, 1150});
    obj.flowLayout5:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout5:setVertAlign("leading");

    obj.flowPart9 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart9:setParent(obj.flowLayout5);
    obj.flowPart9:setHeight(515);
    obj.flowPart9:setFrameStyle("frames/panel5/frame.xml");
    obj.flowPart9:setMargins({left = 4, right = 4});
    obj.flowPart9:setName("flowPart9");
    obj.flowPart9:setStepSizes({});
    obj.flowPart9:setMinWidth(300);
    obj.flowPart9:setMaxWidth(1600);
    obj.flowPart9:setMinScaledWidth(300);
    obj.flowPart9:setVertAlign("leading");

    obj.layout3 = gui.fromHandle(_obj_newObject("layout"));
    obj.layout3:setParent(obj.flowPart9);
    obj.layout3:setAlign("top");
    obj.layout3:setHeight(25);
    obj.layout3:setName("layout3");

    obj.label29 = gui.fromHandle(_obj_newObject("label"));
    obj.label29:setParent(obj.layout3);
    obj.label29:setAlign("top");
    obj.label29:setAutoSize(true);
    obj.label29:setText("PERÍCIAS");
    obj.label29:setFontSize(12);
    obj.label29:setVertTextAlign("center");
    obj.label29:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label29, "fontStyle",  "bold");
    obj.label29:setName("label29");
    obj.label29:setFontColor("white");

    obj.button6 = gui.fromHandle(_obj_newObject("button"));
    obj.button6:setParent(obj.layout3);
    obj.button6:setAlign("left");
    obj.button6:setText("+");
    obj.button6:setWidth(25);
    obj.button6:setHint("Adiciona uma perícia.");
    obj.button6:setHorzTextAlign("center");
    obj.button6:setMargins({top=-10});
    obj.button6:setName("button6");

    obj.rclSkillsNew = gui.fromHandle(_obj_newObject("recordList"));
    obj.rclSkillsNew:setParent(obj.flowPart9);
    obj.rclSkillsNew:setAlign("client");
    obj.rclSkillsNew:setName("rclSkillsNew");
    obj.rclSkillsNew:setField("listaDePericias");
    obj.rclSkillsNew:setTemplateForm("frmSkillItem");
    obj.rclSkillsNew:setLayout("vertical");

    obj.flowLineBreak9 = gui.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak9:setParent(obj.flowLayout5);
    obj.flowLineBreak9:setName("flowLineBreak9");

    obj.flowPart10 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart10:setParent(obj.flowLayout5);
    obj.flowPart10:setHeight(150);
    obj.flowPart10:setFrameStyle("frames/panel5/frame.xml");
    obj.flowPart10:setMargins({left = 4, right = 4});
    obj.flowPart10:setName("flowPart10");
    obj.flowPart10:setStepSizes({});
    obj.flowPart10:setMinWidth(300);
    obj.flowPart10:setMaxWidth(1600);
    obj.flowPart10:setMinScaledWidth(300);
    obj.flowPart10:setVertAlign("leading");

    obj.textEditor2 = gui.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor2:setParent(obj.flowPart10);
    obj.textEditor2:setAlign("client");
    obj.textEditor2:setField("anotacoes_geral");
    obj.textEditor2:setMargins({top=2});
    obj.textEditor2:setFontSize(16);
    obj.textEditor2:setName("textEditor2");
    obj.textEditor2:setTransparent(true);

    obj.flowLineBreak10 = gui.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak10:setParent(obj.flowLayout5);
    obj.flowLineBreak10:setName("flowLineBreak10");

    obj.upperGridMagicBox1 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.upperGridMagicBox1:setParent(obj.flowLayout5);
    obj.upperGridMagicBox1:setHeight(50);
    obj.upperGridMagicBox1:setMinScaledWidth(100);
    obj.upperGridMagicBox1:setMinWidth(100);
    obj.upperGridMagicBox1:setMaxWidth(160);
    obj.upperGridMagicBox1:setMaxScaledWidth(160);
    obj.upperGridMagicBox1:setAvoidScale(true);
    obj.upperGridMagicBox1:setName("upperGridMagicBox1");
    obj.upperGridMagicBox1:setVertAlign("leading");
    obj.upperGridMagicBox1:setMargins({left=5, right=5, top=5, bottom=5});

								
					rawset(self.upperGridMagicBox1, "_RecalcSize", 
						function ()
							self.upperGridMagicBox1:setHeight(self.panupperGridMagicBox1:getHeight() + self.labupperGridMagicBox1:getHeight());
						end);														
				


    obj.panupperGridMagicBox1 = gui.fromHandle(_obj_newObject("frame"));
    obj.panupperGridMagicBox1:setParent(obj.upperGridMagicBox1);
    obj.panupperGridMagicBox1:setName("panupperGridMagicBox1");
    obj.panupperGridMagicBox1:setAlign("top");
    obj.panupperGridMagicBox1:setFrameStyle("frames/panel6/panel6.xml");
    obj.panupperGridMagicBox1:setHeight(60);

    obj.labupperGridMagicBox1val = gui.fromHandle(_obj_newObject("label"));
    obj.labupperGridMagicBox1val:setParent(obj.panupperGridMagicBox1);
    obj.labupperGridMagicBox1val:setName("labupperGridMagicBox1val");
    obj.labupperGridMagicBox1val:setFrameRegion("ContentRegion");
    obj.labupperGridMagicBox1val:setField("pontosRestantes");
    obj.labupperGridMagicBox1val:setFontSize(22);
    obj.labupperGridMagicBox1val:setVertTextAlign("center");
    obj.labupperGridMagicBox1val:setHorzTextAlign("center");
    obj.labupperGridMagicBox1val:setFontColor("white");

    obj.labupperGridMagicBox1 = gui.fromHandle(_obj_newObject("label"));
    obj.labupperGridMagicBox1:setParent(obj.upperGridMagicBox1);
    obj.labupperGridMagicBox1:setName("labupperGridMagicBox1");
    obj.labupperGridMagicBox1:setAlign("top");
    obj.labupperGridMagicBox1:setAutoSize(true);
    obj.labupperGridMagicBox1:setText("PONTOS RESTANTES");
    obj.labupperGridMagicBox1:setHorzTextAlign("center");
    obj.labupperGridMagicBox1:setVertTextAlign("leading");
    obj.labupperGridMagicBox1:setWordWrap(true);
    obj.labupperGridMagicBox1:setTextTrimming("none");
    obj.labupperGridMagicBox1:setFontSize(12);
    obj.labupperGridMagicBox1:setFontColor("#D0D0D0");

self.upperGridMagicBox1._RecalcSize();	


    obj.upperGridMagicEditBox1 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.upperGridMagicEditBox1:setParent(obj.flowLayout5);
    obj.upperGridMagicEditBox1:setHeight(50);
    obj.upperGridMagicEditBox1:setMinScaledWidth(100);
    obj.upperGridMagicEditBox1:setMinWidth(100);
    obj.upperGridMagicEditBox1:setMaxWidth(160);
    obj.upperGridMagicEditBox1:setMaxScaledWidth(160);
    obj.upperGridMagicEditBox1:setAvoidScale(true);
    obj.upperGridMagicEditBox1:setName("upperGridMagicEditBox1");
    obj.upperGridMagicEditBox1:setVertAlign("leading");
    obj.upperGridMagicEditBox1:setMargins({left=5, right=5, top=5, bottom=5});

								
					rawset(self.upperGridMagicEditBox1, "_RecalcSize", 
						function ()
							self.upperGridMagicEditBox1:setHeight(self.panupperGridMagicEditBox1:getHeight() + self.labupperGridMagicEditBox1:getHeight());
						end);														
				


    obj.panupperGridMagicEditBox1 = gui.fromHandle(_obj_newObject("frame"));
    obj.panupperGridMagicEditBox1:setParent(obj.upperGridMagicEditBox1);
    obj.panupperGridMagicEditBox1:setName("panupperGridMagicEditBox1");
    obj.panupperGridMagicEditBox1:setAlign("top");
    obj.panupperGridMagicEditBox1:setFrameStyle("frames/panel6/panel6.xml");
    obj.panupperGridMagicEditBox1:setHeight(60);

    obj.edtupperGridMagicEditBox1 = gui.fromHandle(_obj_newObject("edit"));
    obj.edtupperGridMagicEditBox1:setParent(obj.panupperGridMagicEditBox1);
    obj.edtupperGridMagicEditBox1:setName("edtupperGridMagicEditBox1");
    obj.edtupperGridMagicEditBox1:setFrameRegion("ContentRegion");
    obj.edtupperGridMagicEditBox1:setField("totalPontos");
    obj.edtupperGridMagicEditBox1:setFontSize(22);
    obj.edtupperGridMagicEditBox1:setVertTextAlign("center");
    obj.edtupperGridMagicEditBox1:setHorzTextAlign("center");
    obj.edtupperGridMagicEditBox1:setFontColor("white");
    obj.edtupperGridMagicEditBox1:setTransparent(true);

    obj.labupperGridMagicEditBox1 = gui.fromHandle(_obj_newObject("label"));
    obj.labupperGridMagicEditBox1:setParent(obj.upperGridMagicEditBox1);
    obj.labupperGridMagicEditBox1:setName("labupperGridMagicEditBox1");
    obj.labupperGridMagicEditBox1:setAlign("top");
    obj.labupperGridMagicEditBox1:setAutoSize(true);
    obj.labupperGridMagicEditBox1:setText("TOTAL DE PONTOS");
    obj.labupperGridMagicEditBox1:setHorzTextAlign("center");
    obj.labupperGridMagicEditBox1:setVertTextAlign("leading");
    obj.labupperGridMagicEditBox1:setWordWrap(true);
    obj.labupperGridMagicEditBox1:setTextTrimming("none");
    obj.labupperGridMagicEditBox1:setFontSize(12);
    obj.labupperGridMagicEditBox1:setFontColor("#D0D0D0");

self.upperGridMagicEditBox1._RecalcSize();	


    obj.dataLink8 = gui.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink8:setParent(obj.flowLayout5);
    obj.dataLink8:setFields({'totalPontos', 'atributos_st', 'atributos_ht', 'atributos_dx', 'atributos_vt', 'atributos_iq', 'atributos_per', 'atributos_pv', 'atributos_pf', 'atributos_velocidade', 'atributos_deslocamento'});
    obj.dataLink8:setName("dataLink8");

    obj.tab2 = gui.fromHandle(_obj_newObject("tab"));
    obj.tab2:setParent(obj.pgcPrincipal);
    obj.tab2:setTitle("Descrição");
    obj.tab2:setName("tab2");

    obj.rectangle3 = gui.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle3:setParent(obj.tab2);
    obj.rectangle3:setName("rectangle3");
    obj.rectangle3:setAlign("client");
    obj.rectangle3:setColor("#40000000");
    obj.rectangle3:setXradius(10);
    obj.rectangle3:setYradius(10);

    obj.scrollBox2 = gui.fromHandle(_obj_newObject("scrollBox"));
    obj.scrollBox2:setParent(obj.rectangle3);
    obj.scrollBox2:setAlign("client");
    obj.scrollBox2:setName("scrollBox2");

    obj.fraCaracteristicasLayout = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.fraCaracteristicasLayout:setParent(obj.scrollBox2);
    obj.fraCaracteristicasLayout:setAlign("top");
    obj.fraCaracteristicasLayout:setHeight(500);
    obj.fraCaracteristicasLayout:setMargins({left=10, right=10, top=10});
    obj.fraCaracteristicasLayout:setAutoHeight(true);
    obj.fraCaracteristicasLayout:setHorzAlign("center");
    obj.fraCaracteristicasLayout:setLineSpacing(3);
    obj.fraCaracteristicasLayout:setName("fraCaracteristicasLayout");
    obj.fraCaracteristicasLayout:setStepSizes({320, 400});
    obj.fraCaracteristicasLayout:setMinScaledWidth(150);
    obj.fraCaracteristicasLayout:setVertAlign("leading");

    obj.flowLayout6 = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout6:setParent(obj.fraCaracteristicasLayout);
    obj.flowLayout6:setAutoHeight(true);
    obj.flowLayout6:setMinScaledWidth(290);
    obj.flowLayout6:setHorzAlign("center");
    obj.flowLayout6:setName("flowLayout6");
    obj.flowLayout6:setStepSizes({310, 420, 640, 760, 860, 960, 1150, 1200, 1600});
    obj.flowLayout6:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout6:setVertAlign("leading");

    obj.flowPart11 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart11:setParent(obj.flowLayout6);
    obj.flowPart11:setMinWidth(320);
    obj.flowPart11:setHeight(175);
    obj.flowPart11:setMaxWidth(1600);
    obj.flowPart11:setFrameStyle("frames/banner/dragon.xml");
    obj.flowPart11:setVertAlign("center");
    obj.flowPart11:setAvoidScale(true);
    obj.flowPart11:setName("flowPart11");
    obj.flowPart11:setStepSizes({320, 400, 480, 560, 640});
    obj.flowPart11:setMinScaledWidth(150);
    obj.flowPart11:setMargins({left=1, right=1, top=2, bottom=2});

    obj.layout4 = gui.fromHandle(_obj_newObject("layout"));
    obj.layout4:setParent(obj.flowPart11);
    obj.layout4:setAlign("client");
    obj.layout4:setName("layout4");

    obj.edit26 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit26:setParent(obj.layout4);
    obj.edit26:setField("nome");
    obj.edit26:setFontSize(17);
    obj.edit26:setAlign("client");
    obj.edit26:setName("edit26");
    obj.edit26:setFontColor("white");
    obj.edit26:setVertTextAlign("center");
    obj.edit26:setHorzTextAlign("center");
    obj.edit26:setTransparent(true);

    obj.label30 = gui.fromHandle(_obj_newObject("label"));
    obj.label30:setParent(obj.layout4);
    obj.label30:setAlign("bottom");
    obj.label30:setText("NOME DO PERSONAGEM");
    obj.label30:setAutoSize(true);
    obj.label30:setMargins({left=3});
    obj.label30:setName("label30");
    obj.label30:setFontSize(12);
    obj.label30:setFontColor("#D0D0D0");

    obj.fraUpperGridCaracteristicas = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.fraUpperGridCaracteristicas:setParent(obj.flowLayout6);
    obj.fraUpperGridCaracteristicas:setMinWidth(320);
    obj.fraUpperGridCaracteristicas:setMaxWidth(1600);
    obj.fraUpperGridCaracteristicas:setName("fraUpperGridCaracteristicas");
    obj.fraUpperGridCaracteristicas:setAvoidScale(true);
    obj.fraUpperGridCaracteristicas:setFrameStyle("frames/upperInfoGrid/frame.xml");
    obj.fraUpperGridCaracteristicas:setAutoHeight(true);
    obj.fraUpperGridCaracteristicas:setVertAlign("trailing");
    obj.fraUpperGridCaracteristicas:setMaxControlsPerLine(3);
    obj.fraUpperGridCaracteristicas:setStepSizes({320, 400, 480, 560, 640});
    obj.fraUpperGridCaracteristicas:setMinScaledWidth(150);
    obj.fraUpperGridCaracteristicas:setMargins({left=1, right=1, top=2, bottom=2});

    obj.UpperGridCampo1 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.UpperGridCampo1:setParent(obj.fraUpperGridCaracteristicas);
    obj.UpperGridCampo1:setHeight(50);
    obj.UpperGridCampo1:setMinScaledWidth(100);
    obj.UpperGridCampo1:setMinWidth(100);
    obj.UpperGridCampo1:setMaxWidth(233);
    obj.UpperGridCampo1:setMaxScaledWidth(233);
    obj.UpperGridCampo1:setAvoidScale(true);
    obj.UpperGridCampo1:setName("UpperGridCampo1");
    obj.UpperGridCampo1:setMargins({left=1, right=1, top=2, bottom=2});
    obj.UpperGridCampo1:setVertAlign("leading");

    obj.edtUpperGridCampo1 = gui.fromHandle(_obj_newObject("edit"));
    obj.edtUpperGridCampo1:setParent(obj.UpperGridCampo1);
    obj.edtUpperGridCampo1:setName("edtUpperGridCampo1");
    obj.edtUpperGridCampo1:setAlign("top");
    obj.edtUpperGridCampo1:setField("idade");
    obj.edtUpperGridCampo1:setFontSize(13);
    obj.edtUpperGridCampo1:setHeight(30);
    obj.edtUpperGridCampo1:setTransparent(true);
    obj.edtUpperGridCampo1:setVertTextAlign("trailing");
    obj.edtUpperGridCampo1:setWidth(195);
    obj.edtUpperGridCampo1:setFontColor("white");

    obj.linUpperGridCampo1 = gui.fromHandle(_obj_newObject("horzLine"));
    obj.linUpperGridCampo1:setParent(obj.UpperGridCampo1);
    obj.linUpperGridCampo1:setName("linUpperGridCampo1");
    obj.linUpperGridCampo1:setAlign("top");
    obj.linUpperGridCampo1:setStrokeColor("#FFFFFF50");
    obj.linUpperGridCampo1:setStrokeSize(1);

    obj.labUpperGridCampo1 = gui.fromHandle(_obj_newObject("label"));
    obj.labUpperGridCampo1:setParent(obj.UpperGridCampo1);
    obj.labUpperGridCampo1:setName("labUpperGridCampo1");
    obj.labUpperGridCampo1:setAlign("top");
    obj.labUpperGridCampo1:setText("IDADE");
    obj.labUpperGridCampo1:setVertTextAlign("leading");
    obj.labUpperGridCampo1:setWordWrap(true);
    obj.labUpperGridCampo1:setTextTrimming("none");
    obj.labUpperGridCampo1:setFontSize(12);
    obj.labUpperGridCampo1:setFontColor("#D0D0D0");

    self.UpperGridCampo1:setHeight(self.edtUpperGridCampo1:getHeight() + self.labUpperGridCampo1:getHeight() + self.linUpperGridCampo1:getHeight());


    obj.UpperGridCampo2 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.UpperGridCampo2:setParent(obj.fraUpperGridCaracteristicas);
    obj.UpperGridCampo2:setHeight(50);
    obj.UpperGridCampo2:setMinScaledWidth(100);
    obj.UpperGridCampo2:setMinWidth(100);
    obj.UpperGridCampo2:setMaxWidth(233);
    obj.UpperGridCampo2:setMaxScaledWidth(233);
    obj.UpperGridCampo2:setAvoidScale(true);
    obj.UpperGridCampo2:setName("UpperGridCampo2");
    obj.UpperGridCampo2:setMargins({left=1, right=1, top=2, bottom=2});
    obj.UpperGridCampo2:setVertAlign("leading");

    obj.edtUpperGridCampo2 = gui.fromHandle(_obj_newObject("edit"));
    obj.edtUpperGridCampo2:setParent(obj.UpperGridCampo2);
    obj.edtUpperGridCampo2:setName("edtUpperGridCampo2");
    obj.edtUpperGridCampo2:setAlign("top");
    obj.edtUpperGridCampo2:setField("altura");
    obj.edtUpperGridCampo2:setFontSize(13);
    obj.edtUpperGridCampo2:setHeight(30);
    obj.edtUpperGridCampo2:setTransparent(true);
    obj.edtUpperGridCampo2:setVertTextAlign("trailing");
    obj.edtUpperGridCampo2:setWidth(195);
    obj.edtUpperGridCampo2:setFontColor("white");

    obj.linUpperGridCampo2 = gui.fromHandle(_obj_newObject("horzLine"));
    obj.linUpperGridCampo2:setParent(obj.UpperGridCampo2);
    obj.linUpperGridCampo2:setName("linUpperGridCampo2");
    obj.linUpperGridCampo2:setAlign("top");
    obj.linUpperGridCampo2:setStrokeColor("#FFFFFF50");
    obj.linUpperGridCampo2:setStrokeSize(1);

    obj.labUpperGridCampo2 = gui.fromHandle(_obj_newObject("label"));
    obj.labUpperGridCampo2:setParent(obj.UpperGridCampo2);
    obj.labUpperGridCampo2:setName("labUpperGridCampo2");
    obj.labUpperGridCampo2:setAlign("top");
    obj.labUpperGridCampo2:setText("ALTURA");
    obj.labUpperGridCampo2:setVertTextAlign("leading");
    obj.labUpperGridCampo2:setWordWrap(true);
    obj.labUpperGridCampo2:setTextTrimming("none");
    obj.labUpperGridCampo2:setFontSize(12);
    obj.labUpperGridCampo2:setFontColor("#D0D0D0");

    self.UpperGridCampo2:setHeight(self.edtUpperGridCampo2:getHeight() + self.labUpperGridCampo2:getHeight() + self.linUpperGridCampo2:getHeight());


    obj.UpperGridCampo3 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.UpperGridCampo3:setParent(obj.fraUpperGridCaracteristicas);
    obj.UpperGridCampo3:setHeight(50);
    obj.UpperGridCampo3:setMinScaledWidth(100);
    obj.UpperGridCampo3:setMinWidth(100);
    obj.UpperGridCampo3:setMaxWidth(233);
    obj.UpperGridCampo3:setMaxScaledWidth(233);
    obj.UpperGridCampo3:setAvoidScale(true);
    obj.UpperGridCampo3:setName("UpperGridCampo3");
    obj.UpperGridCampo3:setMargins({left=1, right=1, top=2, bottom=2});
    obj.UpperGridCampo3:setVertAlign("leading");

    obj.edtUpperGridCampo3 = gui.fromHandle(_obj_newObject("edit"));
    obj.edtUpperGridCampo3:setParent(obj.UpperGridCampo3);
    obj.edtUpperGridCampo3:setName("edtUpperGridCampo3");
    obj.edtUpperGridCampo3:setAlign("top");
    obj.edtUpperGridCampo3:setField("peso");
    obj.edtUpperGridCampo3:setFontSize(13);
    obj.edtUpperGridCampo3:setHeight(30);
    obj.edtUpperGridCampo3:setTransparent(true);
    obj.edtUpperGridCampo3:setVertTextAlign("trailing");
    obj.edtUpperGridCampo3:setWidth(195);
    obj.edtUpperGridCampo3:setFontColor("white");

    obj.linUpperGridCampo3 = gui.fromHandle(_obj_newObject("horzLine"));
    obj.linUpperGridCampo3:setParent(obj.UpperGridCampo3);
    obj.linUpperGridCampo3:setName("linUpperGridCampo3");
    obj.linUpperGridCampo3:setAlign("top");
    obj.linUpperGridCampo3:setStrokeColor("#FFFFFF50");
    obj.linUpperGridCampo3:setStrokeSize(1);

    obj.labUpperGridCampo3 = gui.fromHandle(_obj_newObject("label"));
    obj.labUpperGridCampo3:setParent(obj.UpperGridCampo3);
    obj.labUpperGridCampo3:setName("labUpperGridCampo3");
    obj.labUpperGridCampo3:setAlign("top");
    obj.labUpperGridCampo3:setText("PESO");
    obj.labUpperGridCampo3:setVertTextAlign("leading");
    obj.labUpperGridCampo3:setWordWrap(true);
    obj.labUpperGridCampo3:setTextTrimming("none");
    obj.labUpperGridCampo3:setFontSize(12);
    obj.labUpperGridCampo3:setFontColor("#D0D0D0");

    self.UpperGridCampo3:setHeight(self.edtUpperGridCampo3:getHeight() + self.labUpperGridCampo3:getHeight() + self.linUpperGridCampo3:getHeight());


    obj.UpperGridCampo4 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.UpperGridCampo4:setParent(obj.fraUpperGridCaracteristicas);
    obj.UpperGridCampo4:setHeight(50);
    obj.UpperGridCampo4:setMinScaledWidth(100);
    obj.UpperGridCampo4:setMinWidth(100);
    obj.UpperGridCampo4:setMaxWidth(233);
    obj.UpperGridCampo4:setMaxScaledWidth(233);
    obj.UpperGridCampo4:setAvoidScale(true);
    obj.UpperGridCampo4:setName("UpperGridCampo4");
    obj.UpperGridCampo4:setMargins({left=1, right=1, top=2, bottom=2});
    obj.UpperGridCampo4:setVertAlign("leading");

    obj.edtUpperGridCampo4 = gui.fromHandle(_obj_newObject("edit"));
    obj.edtUpperGridCampo4:setParent(obj.UpperGridCampo4);
    obj.edtUpperGridCampo4:setName("edtUpperGridCampo4");
    obj.edtUpperGridCampo4:setAlign("top");
    obj.edtUpperGridCampo4:setField("olhos");
    obj.edtUpperGridCampo4:setFontSize(13);
    obj.edtUpperGridCampo4:setHeight(30);
    obj.edtUpperGridCampo4:setTransparent(true);
    obj.edtUpperGridCampo4:setVertTextAlign("trailing");
    obj.edtUpperGridCampo4:setWidth(195);
    obj.edtUpperGridCampo4:setFontColor("white");

    obj.linUpperGridCampo4 = gui.fromHandle(_obj_newObject("horzLine"));
    obj.linUpperGridCampo4:setParent(obj.UpperGridCampo4);
    obj.linUpperGridCampo4:setName("linUpperGridCampo4");
    obj.linUpperGridCampo4:setAlign("top");
    obj.linUpperGridCampo4:setStrokeColor("#FFFFFF50");
    obj.linUpperGridCampo4:setStrokeSize(1);

    obj.labUpperGridCampo4 = gui.fromHandle(_obj_newObject("label"));
    obj.labUpperGridCampo4:setParent(obj.UpperGridCampo4);
    obj.labUpperGridCampo4:setName("labUpperGridCampo4");
    obj.labUpperGridCampo4:setAlign("top");
    obj.labUpperGridCampo4:setText("JOGADOR");
    obj.labUpperGridCampo4:setVertTextAlign("leading");
    obj.labUpperGridCampo4:setWordWrap(true);
    obj.labUpperGridCampo4:setTextTrimming("none");
    obj.labUpperGridCampo4:setFontSize(12);
    obj.labUpperGridCampo4:setFontColor("#D0D0D0");

    self.UpperGridCampo4:setHeight(self.edtUpperGridCampo4:getHeight() + self.labUpperGridCampo4:getHeight() + self.linUpperGridCampo4:getHeight());


    obj.UpperGridCampo5 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.UpperGridCampo5:setParent(obj.fraUpperGridCaracteristicas);
    obj.UpperGridCampo5:setHeight(50);
    obj.UpperGridCampo5:setMinScaledWidth(100);
    obj.UpperGridCampo5:setMinWidth(100);
    obj.UpperGridCampo5:setMaxWidth(233);
    obj.UpperGridCampo5:setMaxScaledWidth(233);
    obj.UpperGridCampo5:setAvoidScale(true);
    obj.UpperGridCampo5:setName("UpperGridCampo5");
    obj.UpperGridCampo5:setMargins({left=1, right=1, top=2, bottom=2});
    obj.UpperGridCampo5:setVertAlign("leading");

    obj.edtUpperGridCampo5 = gui.fromHandle(_obj_newObject("edit"));
    obj.edtUpperGridCampo5:setParent(obj.UpperGridCampo5);
    obj.edtUpperGridCampo5:setName("edtUpperGridCampo5");
    obj.edtUpperGridCampo5:setAlign("top");
    obj.edtUpperGridCampo5:setField("pele");
    obj.edtUpperGridCampo5:setFontSize(13);
    obj.edtUpperGridCampo5:setHeight(30);
    obj.edtUpperGridCampo5:setTransparent(true);
    obj.edtUpperGridCampo5:setVertTextAlign("trailing");
    obj.edtUpperGridCampo5:setWidth(195);
    obj.edtUpperGridCampo5:setFontColor("white");

    obj.linUpperGridCampo5 = gui.fromHandle(_obj_newObject("horzLine"));
    obj.linUpperGridCampo5:setParent(obj.UpperGridCampo5);
    obj.linUpperGridCampo5:setName("linUpperGridCampo5");
    obj.linUpperGridCampo5:setAlign("top");
    obj.linUpperGridCampo5:setStrokeColor("#FFFFFF50");
    obj.linUpperGridCampo5:setStrokeSize(1);

    obj.labUpperGridCampo5 = gui.fromHandle(_obj_newObject("label"));
    obj.labUpperGridCampo5:setParent(obj.UpperGridCampo5);
    obj.labUpperGridCampo5:setName("labUpperGridCampo5");
    obj.labUpperGridCampo5:setAlign("top");
    obj.labUpperGridCampo5:setText("TAMANHO");
    obj.labUpperGridCampo5:setVertTextAlign("leading");
    obj.labUpperGridCampo5:setWordWrap(true);
    obj.labUpperGridCampo5:setTextTrimming("none");
    obj.labUpperGridCampo5:setFontSize(12);
    obj.labUpperGridCampo5:setFontColor("#D0D0D0");

    self.UpperGridCampo5:setHeight(self.edtUpperGridCampo5:getHeight() + self.labUpperGridCampo5:getHeight() + self.linUpperGridCampo5:getHeight());


    obj.UpperGridCampo6 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.UpperGridCampo6:setParent(obj.fraUpperGridCaracteristicas);
    obj.UpperGridCampo6:setHeight(50);
    obj.UpperGridCampo6:setMinScaledWidth(100);
    obj.UpperGridCampo6:setMinWidth(100);
    obj.UpperGridCampo6:setMaxWidth(233);
    obj.UpperGridCampo6:setMaxScaledWidth(233);
    obj.UpperGridCampo6:setAvoidScale(true);
    obj.UpperGridCampo6:setName("UpperGridCampo6");
    obj.UpperGridCampo6:setMargins({left=1, right=1, top=2, bottom=2});
    obj.UpperGridCampo6:setVertAlign("leading");

    obj.edtUpperGridCampo6 = gui.fromHandle(_obj_newObject("edit"));
    obj.edtUpperGridCampo6:setParent(obj.UpperGridCampo6);
    obj.edtUpperGridCampo6:setName("edtUpperGridCampo6");
    obj.edtUpperGridCampo6:setAlign("top");
    obj.edtUpperGridCampo6:setField("cabelo");
    obj.edtUpperGridCampo6:setFontSize(13);
    obj.edtUpperGridCampo6:setHeight(30);
    obj.edtUpperGridCampo6:setTransparent(true);
    obj.edtUpperGridCampo6:setVertTextAlign("trailing");
    obj.edtUpperGridCampo6:setWidth(195);
    obj.edtUpperGridCampo6:setFontColor("white");

    obj.linUpperGridCampo6 = gui.fromHandle(_obj_newObject("horzLine"));
    obj.linUpperGridCampo6:setParent(obj.UpperGridCampo6);
    obj.linUpperGridCampo6:setName("linUpperGridCampo6");
    obj.linUpperGridCampo6:setAlign("top");
    obj.linUpperGridCampo6:setStrokeColor("#FFFFFF50");
    obj.linUpperGridCampo6:setStrokeSize(1);

    obj.labUpperGridCampo6 = gui.fromHandle(_obj_newObject("label"));
    obj.labUpperGridCampo6:setParent(obj.UpperGridCampo6);
    obj.labUpperGridCampo6:setName("labUpperGridCampo6");
    obj.labUpperGridCampo6:setAlign("top");
    obj.labUpperGridCampo6:setText("REAÇÃO");
    obj.labUpperGridCampo6:setVertTextAlign("leading");
    obj.labUpperGridCampo6:setWordWrap(true);
    obj.labUpperGridCampo6:setTextTrimming("none");
    obj.labUpperGridCampo6:setFontSize(12);
    obj.labUpperGridCampo6:setFontColor("#D0D0D0");

    self.UpperGridCampo6:setHeight(self.edtUpperGridCampo6:getHeight() + self.labUpperGridCampo6:getHeight() + self.linUpperGridCampo6:getHeight());


    obj.flowLineBreak11 = gui.fromHandle(_obj_newObject("flowLineBreak"));
    obj.flowLineBreak11:setParent(obj.fraCaracteristicasLayout);
    obj.flowLineBreak11:setName("flowLineBreak11");

    obj.flowLayout7 = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout7:setParent(obj.fraCaracteristicasLayout);
    obj.flowLayout7:setAutoHeight(true);
    obj.flowLayout7:setMinScaledWidth(290);
    obj.flowLayout7:setHorzAlign("center");
    obj.flowLayout7:setLineSpacing(10);
    obj.flowLayout7:setName("flowLayout7");
    obj.flowLayout7:setStepSizes({310, 420, 640, 760, 860, 960, 1150, 1200, 1600});
    obj.flowLayout7:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowLayout7:setVertAlign("leading");

    obj.flowPart12 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart12:setParent(obj.flowLayout7);
    obj.flowPart12:setHeight(515);
    obj.flowPart12:setFrameStyle("frames/panel5/frame.xml");
    obj.flowPart12:setMargins({left = 4, right = 4});
    obj.flowPart12:setName("flowPart12");
    obj.flowPart12:setStepSizes({});
    obj.flowPart12:setMinWidth(300);
    obj.flowPart12:setMaxWidth(1600);
    obj.flowPart12:setMinScaledWidth(300);
    obj.flowPart12:setVertAlign("leading");

    obj.richEdit1 = gui.fromHandle(_obj_newObject("richEdit"));
    obj.richEdit1:setParent(obj.flowPart12);
    obj.richEdit1:setAlign("client");
    obj.richEdit1:setField("background");
    lfm_setPropAsString(obj.richEdit1, "backgroundColor",  "#333333");
    lfm_setPropAsString(obj.richEdit1, "defaultFontSize",  "12");
    lfm_setPropAsString(obj.richEdit1, "defaultFontColor",  "white");
    obj.richEdit1:setName("richEdit1");

    obj.label31 = gui.fromHandle(_obj_newObject("label"));
    obj.label31:setParent(obj.flowPart12);
    obj.label31:setAlign("bottom");
    obj.label31:setAutoSize(true);
    obj.label31:setText("HISTORIA");
    obj.label31:setFontSize(12);
    obj.label31:setVertTextAlign("center");
    obj.label31:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label31, "fontStyle",  "bold");
    obj.label31:setName("label31");
    obj.label31:setFontColor("white");

    obj.flowLayout8 = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout8:setParent(obj.flowLayout7);
    obj.flowLayout8:setMaxControlsPerLine(1);
    obj.flowLayout8:setAutoHeight(true);
    obj.flowLayout8:setLineSpacing(10);
    obj.flowLayout8:setMargins({left=4, right=4});
    obj.flowLayout8:setName("flowLayout8");
    obj.flowLayout8:setStepSizes({});
    obj.flowLayout8:setMinWidth(300);
    obj.flowLayout8:setMaxWidth(1600);
    obj.flowLayout8:setMinScaledWidth(300);
    obj.flowLayout8:setVertAlign("leading");

    obj.flowPart13 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart13:setParent(obj.flowLayout8);
    obj.flowPart13:setHeight(170);
    obj.flowPart13:setFrameStyle("frames/panel5/topPanel.xml");
    obj.flowPart13:setMargins({left = 4, right = 4});
    obj.flowPart13:setName("flowPart13");
    obj.flowPart13:setStepSizes({});
    obj.flowPart13:setMinWidth(300);
    obj.flowPart13:setMaxWidth(1600);
    obj.flowPart13:setMinScaledWidth(300);
    obj.flowPart13:setVertAlign("leading");

    obj.label32 = gui.fromHandle(_obj_newObject("label"));
    obj.label32:setParent(obj.flowPart13);
    obj.label32:setAlign("top");
    obj.label32:setAutoSize(true);
    obj.label32:setText("APARÊNCIA");
    obj.label32:setFontSize(12);
    obj.label32:setVertTextAlign("center");
    obj.label32:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label32, "fontStyle",  "bold");
    obj.label32:setName("label32");
    obj.label32:setFontColor("white");

    obj.textEditor3 = gui.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor3:setParent(obj.flowPart13);
    obj.textEditor3:setAlign("client");
    obj.textEditor3:setField("aparencia");
    obj.textEditor3:setMargins({top=2});
    obj.textEditor3:setFontSize(16);
    obj.textEditor3:setName("textEditor3");
    obj.textEditor3:setTransparent(true);

    obj.flowPart14 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart14:setParent(obj.flowLayout8);
    obj.flowPart14:setHeight(170);
    obj.flowPart14:setFrameStyle("frames/panel5/centerPanel.xml");
    obj.flowPart14:setMargins({left = 4, right = 4});
    obj.flowPart14:setName("flowPart14");
    obj.flowPart14:setStepSizes({});
    obj.flowPart14:setMinWidth(300);
    obj.flowPart14:setMaxWidth(1600);
    obj.flowPart14:setMinScaledWidth(300);
    obj.flowPart14:setVertAlign("leading");

    obj.label33 = gui.fromHandle(_obj_newObject("label"));
    obj.label33:setParent(obj.flowPart14);
    obj.label33:setAlign("top");
    obj.label33:setAutoSize(true);
    obj.label33:setText("QUALIDADES");
    obj.label33:setFontSize(12);
    obj.label33:setVertTextAlign("center");
    obj.label33:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label33, "fontStyle",  "bold");
    obj.label33:setName("label33");
    obj.label33:setFontColor("white");

    obj.textEditor4 = gui.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor4:setParent(obj.flowPart14);
    obj.textEditor4:setAlign("client");
    obj.textEditor4:setField("anotacoes");
    obj.textEditor4:setMargins({top=2});
    obj.textEditor4:setFontSize(16);
    obj.textEditor4:setName("textEditor4");
    obj.textEditor4:setTransparent(true);

    obj.flowPart15 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart15:setParent(obj.flowLayout8);
    obj.flowPart15:setHeight(155);
    obj.flowPart15:setFrameStyle("frames/panel5/bottomPanel.xml");
    obj.flowPart15:setMargins({left = 4, right = 4});
    obj.flowPart15:setName("flowPart15");
    obj.flowPart15:setStepSizes({});
    obj.flowPart15:setMinWidth(300);
    obj.flowPart15:setMaxWidth(1600);
    obj.flowPart15:setMinScaledWidth(300);
    obj.flowPart15:setVertAlign("leading");

    obj.label34 = gui.fromHandle(_obj_newObject("label"));
    obj.label34:setParent(obj.flowPart15);
    obj.label34:setAlign("top");
    obj.label34:setAutoSize(true);
    obj.label34:setText("PECULIARIDADES");
    obj.label34:setFontSize(12);
    obj.label34:setVertTextAlign("center");
    obj.label34:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label34, "fontStyle",  "bold");
    obj.label34:setName("label34");
    obj.label34:setFontColor("white");

    obj.textEditor5 = gui.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor5:setParent(obj.flowPart15);
    obj.textEditor5:setAlign("client");
    obj.textEditor5:setField("peculiaridades");
    obj.textEditor5:setMargins({top=2});
    obj.textEditor5:setFontSize(16);
    obj.textEditor5:setName("textEditor5");
    obj.textEditor5:setTransparent(true);

    obj.tab3 = gui.fromHandle(_obj_newObject("tab"));
    obj.tab3:setParent(obj.pgcPrincipal);
    obj.tab3:setTitle("Capacidades");
    obj.tab3:setName("tab3");

    obj.rectangle4 = gui.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle4:setParent(obj.tab3);
    obj.rectangle4:setName("rectangle4");
    obj.rectangle4:setAlign("client");
    obj.rectangle4:setColor("#40000000");
    obj.rectangle4:setXradius(10);
    obj.rectangle4:setYradius(10);

    obj.popPower = gui.fromHandle(_obj_newObject("popup"));
    obj.popPower:setParent(obj.rectangle4);
    obj.popPower:setName("popPower");
    obj.popPower:setWidth(250);
    obj.popPower:setHeight(250);
    obj.popPower:setBackOpacity(0.4);

    obj.edit27 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit27:setParent(obj.popPower);
    obj.edit27:setAlign("top");
    obj.edit27:setField("nome");
    obj.edit27:setTextPrompt("NOME DA MAGIA");
    obj.edit27:setHorzTextAlign("center");
    obj.edit27:setName("edit27");
    obj.edit27:setFontSize(15);
    obj.edit27:setFontColor("white");

    obj.flowLayout9 = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.flowLayout9:setParent(obj.popPower);
    obj.flowLayout9:setAlign("top");
    obj.flowLayout9:setAutoHeight(true);
    obj.flowLayout9:setMaxControlsPerLine(2);
    obj.flowLayout9:setMargins({bottom=4});
    obj.flowLayout9:setHorzAlign("center");
    obj.flowLayout9:setName("flowLayout9");
    obj.flowLayout9:setVertAlign("leading");

    obj.flowPart16 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart16:setParent(obj.flowLayout9);
    obj.flowPart16:setMinWidth(30);
    obj.flowPart16:setMaxWidth(400);
    obj.flowPart16:setHeight(35);
    obj.flowPart16:setName("flowPart16");
    obj.flowPart16:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart16:setVertAlign("leading");

    obj.label35 = gui.fromHandle(_obj_newObject("label"));
    obj.label35:setParent(obj.flowPart16);
    obj.label35:setAlign("top");
    obj.label35:setFontSize(10);
    obj.label35:setText("TIPO");
    obj.label35:setHorzTextAlign("center");
    obj.label35:setWordWrap(true);
    obj.label35:setTextTrimming("none");
    obj.label35:setAutoSize(true);
    obj.label35:setName("label35");
    obj.label35:setFontColor("#D0D0D0");

    obj.edit28 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit28:setParent(obj.flowPart16);
    obj.edit28:setAlign("client");
    obj.edit28:setField("tipo");
    obj.edit28:setHorzTextAlign("center");
    obj.edit28:setFontSize(12);
    obj.edit28:setName("edit28");
    obj.edit28:setFontColor("white");

    obj.flowPart17 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart17:setParent(obj.flowLayout9);
    obj.flowPart17:setMinWidth(30);
    obj.flowPart17:setMaxWidth(400);
    obj.flowPart17:setHeight(35);
    obj.flowPart17:setName("flowPart17");
    obj.flowPart17:setMargins({left=1, right=1, top=2, bottom=2});
    obj.flowPart17:setVertAlign("leading");

    obj.label36 = gui.fromHandle(_obj_newObject("label"));
    obj.label36:setParent(obj.flowPart17);
    obj.label36:setAlign("top");
    obj.label36:setFontSize(10);
    obj.label36:setText("CUSTO");
    obj.label36:setHorzTextAlign("center");
    obj.label36:setWordWrap(true);
    obj.label36:setTextTrimming("none");
    obj.label36:setAutoSize(true);
    obj.label36:setName("label36");
    obj.label36:setFontColor("#D0D0D0");

    obj.edit29 = gui.fromHandle(_obj_newObject("edit"));
    obj.edit29:setParent(obj.flowPart17);
    obj.edit29:setAlign("client");
    obj.edit29:setField("custo");
    obj.edit29:setHorzTextAlign("center");
    obj.edit29:setFontSize(12);
    obj.edit29:setName("edit29");
    obj.edit29:setFontColor("white");

    obj.textEditor6 = gui.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor6:setParent(obj.popPower);
    obj.textEditor6:setAlign("client");
    obj.textEditor6:setField("descricao");
    obj.textEditor6:setName("textEditor6");

    obj.scrollBox3 = gui.fromHandle(_obj_newObject("scrollBox"));
    obj.scrollBox3:setParent(obj.rectangle4);
    obj.scrollBox3:setAlign("client");
    obj.scrollBox3:setName("scrollBox3");

    obj.fraPoderesLayout = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.fraPoderesLayout:setParent(obj.scrollBox3);
    obj.fraPoderesLayout:setAlign("top");
    obj.fraPoderesLayout:setHeight(500);
    obj.fraPoderesLayout:setMargins({left=10, right=10, top=10});
    obj.fraPoderesLayout:setAutoHeight(true);
    obj.fraPoderesLayout:setHorzAlign("center");
    obj.fraPoderesLayout:setLineSpacing(3);
    obj.fraPoderesLayout:setName("fraPoderesLayout");
    obj.fraPoderesLayout:setStepSizes({320, 400});
    obj.fraPoderesLayout:setMinScaledWidth(150);
    obj.fraPoderesLayout:setVertAlign("leading");

    obj.flowPart18 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart18:setParent(obj.fraPoderesLayout);
    obj.flowPart18:setHeight(600);
    obj.flowPart18:setFrameStyle("frames/panel5/frame.xml");
    obj.flowPart18:setMargins({left = 4, right = 4});
    obj.flowPart18:setName("flowPart18");
    obj.flowPart18:setStepSizes({});
    obj.flowPart18:setMinWidth(300);
    obj.flowPart18:setMaxWidth(1600);
    obj.flowPart18:setMinScaledWidth(300);
    obj.flowPart18:setVertAlign("leading");

    obj.layout5 = gui.fromHandle(_obj_newObject("layout"));
    obj.layout5:setParent(obj.flowPart18);
    obj.layout5:setAlign("top");
    obj.layout5:setHeight(25);
    obj.layout5:setName("layout5");

    obj.label37 = gui.fromHandle(_obj_newObject("label"));
    obj.label37:setParent(obj.layout5);
    obj.label37:setAlign("top");
    obj.label37:setAutoSize(true);
    obj.label37:setText("TECNICAS");
    obj.label37:setFontSize(12);
    obj.label37:setVertTextAlign("center");
    obj.label37:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label37, "fontStyle",  "bold");
    obj.label37:setName("label37");
    obj.label37:setFontColor("white");

    obj.button7 = gui.fromHandle(_obj_newObject("button"));
    obj.button7:setParent(obj.layout5);
    obj.button7:setAlign("left");
    obj.button7:setText("+");
    obj.button7:setWidth(25);
    obj.button7:setHint("Adiciona uma tecnica.");
    obj.button7:setHorzTextAlign("center");
    obj.button7:setMargins({top=-10});
    obj.button7:setName("button7");

    obj.rclTech = gui.fromHandle(_obj_newObject("recordList"));
    obj.rclTech:setParent(obj.flowPart18);
    obj.rclTech:setAlign("top");
    obj.rclTech:setHeight(575);
    obj.rclTech:setName("rclTech");
    obj.rclTech:setField("listaDeTecnicas");
    obj.rclTech:setTemplateForm("frmMagiaItemSemCheckbox");
    obj.rclTech:setLayout("vertical");

    obj.flowPart19 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart19:setParent(obj.fraPoderesLayout);
    obj.flowPart19:setHeight(600);
    obj.flowPart19:setFrameStyle("frames/panel5/frame.xml");
    obj.flowPart19:setMargins({left = 4, right = 4});
    obj.flowPart19:setName("flowPart19");
    obj.flowPart19:setStepSizes({});
    obj.flowPart19:setMinWidth(300);
    obj.flowPart19:setMaxWidth(1600);
    obj.flowPart19:setMinScaledWidth(300);
    obj.flowPart19:setVertAlign("leading");

    obj.layout6 = gui.fromHandle(_obj_newObject("layout"));
    obj.layout6:setParent(obj.flowPart19);
    obj.layout6:setAlign("top");
    obj.layout6:setHeight(25);
    obj.layout6:setName("layout6");

    obj.label38 = gui.fromHandle(_obj_newObject("label"));
    obj.label38:setParent(obj.layout6);
    obj.label38:setAlign("top");
    obj.label38:setAutoSize(true);
    obj.label38:setText("MAGIAS");
    obj.label38:setFontSize(12);
    obj.label38:setVertTextAlign("center");
    obj.label38:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label38, "fontStyle",  "bold");
    obj.label38:setName("label38");
    obj.label38:setFontColor("white");

    obj.button8 = gui.fromHandle(_obj_newObject("button"));
    obj.button8:setParent(obj.layout6);
    obj.button8:setAlign("left");
    obj.button8:setText("+");
    obj.button8:setWidth(25);
    obj.button8:setHint("Adiciona uma tecnica.");
    obj.button8:setHorzTextAlign("center");
    obj.button8:setMargins({top=-10});
    obj.button8:setName("button8");

    obj.rclMagic = gui.fromHandle(_obj_newObject("recordList"));
    obj.rclMagic:setParent(obj.flowPart19);
    obj.rclMagic:setAlign("top");
    obj.rclMagic:setHeight(575);
    obj.rclMagic:setName("rclMagic");
    obj.rclMagic:setField("listaDeMagias");
    obj.rclMagic:setTemplateForm("frmMagiaItemSemCheckbox");
    obj.rclMagic:setLayout("vertical");

    obj.tab4 = gui.fromHandle(_obj_newObject("tab"));
    obj.tab4:setParent(obj.pgcPrincipal);
    obj.tab4:setTitle("Inventario");
    obj.tab4:setName("tab4");

    obj.rectangle5 = gui.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle5:setParent(obj.tab4);
    obj.rectangle5:setName("rectangle5");
    obj.rectangle5:setAlign("client");
    obj.rectangle5:setColor("#40000000");
    obj.rectangle5:setXradius(10);
    obj.rectangle5:setYradius(10);

    obj.scrollBox4 = gui.fromHandle(_obj_newObject("scrollBox"));
    obj.scrollBox4:setParent(obj.rectangle5);
    obj.scrollBox4:setAlign("client");
    obj.scrollBox4:setName("scrollBox4");

    obj.fraInventarioLayout = gui.fromHandle(_obj_newObject("flowLayout"));
    obj.fraInventarioLayout:setParent(obj.scrollBox4);
    obj.fraInventarioLayout:setAlign("top");
    obj.fraInventarioLayout:setHeight(500);
    obj.fraInventarioLayout:setMargins({left=10, right=10, top=10});
    obj.fraInventarioLayout:setAutoHeight(true);
    obj.fraInventarioLayout:setHorzAlign("center");
    obj.fraInventarioLayout:setLineSpacing(3);
    obj.fraInventarioLayout:setName("fraInventarioLayout");
    obj.fraInventarioLayout:setStepSizes({320, 400});
    obj.fraInventarioLayout:setMinScaledWidth(150);
    obj.fraInventarioLayout:setVertAlign("leading");

    obj.flowPart20 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart20:setParent(obj.fraInventarioLayout);
    obj.flowPart20:setHeight(600);
    obj.flowPart20:setFrameStyle("frames/panel5/frame.xml");
    obj.flowPart20:setMargins({left = 4, right = 4});
    obj.flowPart20:setName("flowPart20");
    obj.flowPart20:setStepSizes({});
    obj.flowPart20:setMinWidth(300);
    obj.flowPart20:setMaxWidth(1600);
    obj.flowPart20:setMinScaledWidth(300);
    obj.flowPart20:setVertAlign("leading");

    obj.layout7 = gui.fromHandle(_obj_newObject("layout"));
    obj.layout7:setParent(obj.flowPart20);
    obj.layout7:setAlign("top");
    obj.layout7:setHeight(25);
    obj.layout7:setName("layout7");

    obj.label39 = gui.fromHandle(_obj_newObject("label"));
    obj.label39:setParent(obj.layout7);
    obj.label39:setAlign("top");
    obj.label39:setAutoSize(true);
    obj.label39:setText("MOCHILA");
    obj.label39:setFontSize(12);
    obj.label39:setVertTextAlign("center");
    obj.label39:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label39, "fontStyle",  "bold");
    obj.label39:setName("label39");
    obj.label39:setFontColor("white");

    obj.button9 = gui.fromHandle(_obj_newObject("button"));
    obj.button9:setParent(obj.layout7);
    obj.button9:setAlign("left");
    obj.button9:setText("+");
    obj.button9:setWidth(25);
    obj.button9:setHint("");
    obj.button9:setHorzTextAlign("center");
    obj.button9:setMargins({top=-10});
    obj.button9:setName("button9");

    obj.rclBackpack = gui.fromHandle(_obj_newObject("recordList"));
    obj.rclBackpack:setParent(obj.flowPart20);
    obj.rclBackpack:setAlign("client");
    obj.rclBackpack:setName("rclBackpack");
    obj.rclBackpack:setField("listaDeItens");
    obj.rclBackpack:setTemplateForm("frmBackpackItem");
    obj.rclBackpack:setLayout("vertical");
    obj.rclBackpack:setMinQt(3);

    obj.flowPart21 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart21:setParent(obj.fraInventarioLayout);
    obj.flowPart21:setHeight(600);
    obj.flowPart21:setFrameStyle("frames/panel5/frame.xml");
    obj.flowPart21:setMargins({left = 4, right = 4});
    obj.flowPart21:setName("flowPart21");
    obj.flowPart21:setStepSizes({});
    obj.flowPart21:setMinWidth(300);
    obj.flowPart21:setMaxWidth(1600);
    obj.flowPart21:setMinScaledWidth(300);
    obj.flowPart21:setVertAlign("leading");

    obj.layout8 = gui.fromHandle(_obj_newObject("layout"));
    obj.layout8:setParent(obj.flowPart21);
    obj.layout8:setAlign("top");
    obj.layout8:setHeight(25);
    obj.layout8:setName("layout8");

    obj.label40 = gui.fromHandle(_obj_newObject("label"));
    obj.label40:setParent(obj.layout8);
    obj.label40:setAlign("top");
    obj.label40:setAutoSize(true);
    obj.label40:setText("EQUIPAMENTOS E OBJETOS");
    obj.label40:setFontSize(12);
    obj.label40:setVertTextAlign("center");
    obj.label40:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label40, "fontStyle",  "bold");
    obj.label40:setName("label40");
    obj.label40:setFontColor("white");

    obj.button10 = gui.fromHandle(_obj_newObject("button"));
    obj.button10:setParent(obj.layout8);
    obj.button10:setAlign("left");
    obj.button10:setText("+");
    obj.button10:setWidth(25);
    obj.button10:setHint("");
    obj.button10:setHorzTextAlign("center");
    obj.button10:setMargins({top=-10});
    obj.button10:setName("button10");

    obj.rclEquipments = gui.fromHandle(_obj_newObject("recordList"));
    obj.rclEquipments:setParent(obj.flowPart21);
    obj.rclEquipments:setAlign("client");
    obj.rclEquipments:setName("rclEquipments");
    obj.rclEquipments:setField("listaDeEquipamentos");
    obj.rclEquipments:setTemplateForm("frmBackpackItem");
    obj.rclEquipments:setLayout("vertical");

    obj.flowPart22 = gui.fromHandle(_obj_newObject("flowPart"));
    obj.flowPart22:setParent(obj.fraInventarioLayout);
    obj.flowPart22:setHeight(600);
    obj.flowPart22:setFrameStyle("frames/panel5/frame.xml");
    obj.flowPart22:setMargins({left = 4, right = 4});
    obj.flowPart22:setName("flowPart22");
    obj.flowPart22:setStepSizes({});
    obj.flowPart22:setMinWidth(300);
    obj.flowPart22:setMaxWidth(1600);
    obj.flowPart22:setMinScaledWidth(300);
    obj.flowPart22:setVertAlign("leading");

    obj.label41 = gui.fromHandle(_obj_newObject("label"));
    obj.label41:setParent(obj.flowPart22);
    obj.label41:setAlign("top");
    obj.label41:setAutoSize(true);
    obj.label41:setText("EQUIPAMENTOS E POSSES");
    obj.label41:setFontSize(12);
    obj.label41:setVertTextAlign("center");
    obj.label41:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label41, "fontStyle",  "bold");
    obj.label41:setName("label41");
    obj.label41:setFontColor("white");

    obj.textEditor7 = gui.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor7:setParent(obj.flowPart22);
    obj.textEditor7:setAlign("client");
    obj.textEditor7:setField("outrosEquipamentos");
    obj.textEditor7:setMargins({top=2});
    obj.textEditor7:setFontSize(16);
    obj.textEditor7:setName("textEditor7");
    obj.textEditor7:setTransparent(true);

    obj.tab5 = gui.fromHandle(_obj_newObject("tab"));
    obj.tab5:setParent(obj.pgcPrincipal);
    obj.tab5:setTitle("Anotações");
    obj.tab5:setName("tab5");

    obj.frmBlank = gui.fromHandle(_obj_newObject("form"));
    obj.frmBlank:setParent(obj.tab5);
    obj.frmBlank:setName("frmBlank");
    obj.frmBlank:setAlign("client");

    obj.scrollBox5 = gui.fromHandle(_obj_newObject("scrollBox"));
    obj.scrollBox5:setParent(obj.frmBlank);
    obj.scrollBox5:setAlign("client");
    obj.scrollBox5:setName("scrollBox5");

    obj.textEditor8 = gui.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor8:setParent(obj.scrollBox5);
    obj.textEditor8:setAlign("client");
    obj.textEditor8:setField("anotacoesLivres");
    obj.textEditor8:setName("textEditor8");

    obj.tab6 = gui.fromHandle(_obj_newObject("tab"));
    obj.tab6:setParent(obj.pgcPrincipal);
    obj.tab6:setTitle("Creditos");
    obj.tab6:setName("tab6");

    obj.frmTemplateCreditos = gui.fromHandle(_obj_newObject("form"));
    obj.frmTemplateCreditos:setParent(obj.tab6);
    obj.frmTemplateCreditos:setName("frmTemplateCreditos");
    obj.frmTemplateCreditos:setAlign("client");

    obj.rectangle6 = gui.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle6:setParent(obj.frmTemplateCreditos);
    obj.rectangle6:setName("rectangle6");
    obj.rectangle6:setAlign("client");
    obj.rectangle6:setColor("#40000000");
    obj.rectangle6:setXradius(10);
    obj.rectangle6:setYradius(10);

    obj.scrollBox6 = gui.fromHandle(_obj_newObject("scrollBox"));
    obj.scrollBox6:setParent(obj.rectangle6);
    obj.scrollBox6:setAlign("client");
    obj.scrollBox6:setName("scrollBox6");

    obj.image1 = gui.fromHandle(_obj_newObject("image"));
    obj.image1:setParent(obj.scrollBox6);
    obj.image1:setLeft(0);
    obj.image1:setTop(0);
    obj.image1:setWidth(500);
    obj.image1:setHeight(345);
    obj.image1:setStyle("autoFit");
    obj.image1:setSRC("/GURPS4E/images/GURPS4E.png");
    obj.image1:setName("image1");

    obj.image2 = gui.fromHandle(_obj_newObject("image"));
    obj.image2:setParent(obj.scrollBox6);
    obj.image2:setLeft(550);
    obj.image2:setTop(0);
    obj.image2:setWidth(250);
    obj.image2:setHeight(250);
    obj.image2:setStyle("autoFit");
    obj.image2:setSRC("/GURPS4E/images/RPGmeister.jpg");
    obj.image2:setName("image2");

    obj.image3 = gui.fromHandle(_obj_newObject("image"));
    obj.image3:setParent(obj.scrollBox6);
    obj.image3:setLeft(850);
    obj.image3:setTop(0);
    obj.image3:setWidth(250);
    obj.image3:setHeight(250);
    obj.image3:setStyle("autoFit");
    obj.image3:setSRC("/GURPS4E/images/Capa.png");
    obj.image3:setName("image3");

    obj.layout9 = gui.fromHandle(_obj_newObject("layout"));
    obj.layout9:setParent(obj.scrollBox6);
    obj.layout9:setLeft(150);
    obj.layout9:setTop(250);
    obj.layout9:setWidth(200);
    obj.layout9:setHeight(160);
    obj.layout9:setName("layout9");

    obj.rectangle7 = gui.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle7:setParent(obj.layout9);
    obj.rectangle7:setAlign("client");
    obj.rectangle7:setColor("black");
    obj.rectangle7:setXradius(5);
    obj.rectangle7:setYradius(15);
    obj.rectangle7:setCornerType("round");
    obj.rectangle7:setName("rectangle7");

    obj.label42 = gui.fromHandle(_obj_newObject("label"));
    obj.label42:setParent(obj.layout9);
    obj.label42:setLeft(0);
    obj.label42:setTop(10);
    obj.label42:setWidth(200);
    obj.label42:setHeight(20);
    obj.label42:setText("Programador: Vinny (Ambesek)");
    obj.label42:setHorzTextAlign("center");
    obj.label42:setName("label42");
    obj.label42:setFontColor("white");

    obj.label43 = gui.fromHandle(_obj_newObject("label"));
    obj.label43:setParent(obj.layout9);
    obj.label43:setLeft(0);
    obj.label43:setTop(35);
    obj.label43:setWidth(200);
    obj.label43:setHeight(20);
    obj.label43:setText("Consultor: rexLiterate");
    obj.label43:setHorzTextAlign("center");
    obj.label43:setName("label43");
    obj.label43:setFontColor("white");

    obj.label44 = gui.fromHandle(_obj_newObject("label"));
    obj.label44:setParent(obj.scrollBox6);
    obj.label44:setLeft(555);
    obj.label44:setTop(300);
    obj.label44:setWidth(100);
    obj.label44:setHeight(20);
    obj.label44:setText("Versão Atual: ");
    obj.label44:setHorzTextAlign("center");
    obj.label44:setName("label44");
    obj.label44:setFontColor("white");

    obj.image4 = gui.fromHandle(_obj_newObject("image"));
    obj.image4:setParent(obj.scrollBox6);
    obj.image4:setLeft(667);
    obj.image4:setTop(300);
    obj.image4:setWidth(100);
    obj.image4:setHeight(20);
    obj.image4:setStyle("autoFit");
    obj.image4:setSRC("http://www.cin.ufpe.br/~jvdl/Plugins/Ficha%20GURPS%204E/release.png");
    obj.image4:setName("image4");

    obj.label45 = gui.fromHandle(_obj_newObject("label"));
    obj.label45:setParent(obj.scrollBox6);
    obj.label45:setLeft(555);
    obj.label45:setTop(325);
    obj.label45:setWidth(100);
    obj.label45:setHeight(20);
    obj.label45:setText("Sua Versão: ");
    obj.label45:setHorzTextAlign("center");
    obj.label45:setName("label45");
    obj.label45:setFontColor("white");

    obj.image5 = gui.fromHandle(_obj_newObject("image"));
    obj.image5:setParent(obj.scrollBox6);
    obj.image5:setLeft(667);
    obj.image5:setTop(325);
    obj.image5:setWidth(100);
    obj.image5:setHeight(20);
    obj.image5:setStyle("autoFit");
    obj.image5:setSRC("http://www.cin.ufpe.br/~jvdl/Plugins/Version/versao06.png");
    obj.image5:setName("image5");

    obj.button11 = gui.fromHandle(_obj_newObject("button"));
    obj.button11:setParent(obj.scrollBox6);
    obj.button11:setLeft(555);
    obj.button11:setTop(350);
    obj.button11:setWidth(100);
    obj.button11:setText("Change Log");
    obj.button11:setName("button11");

    obj.button12 = gui.fromHandle(_obj_newObject("button"));
    obj.button12:setParent(obj.scrollBox6);
    obj.button12:setLeft(667);
    obj.button12:setTop(350);
    obj.button12:setWidth(100);
    obj.button12:setText("Atualizar");
    obj.button12:setName("button12");

    obj.label46 = gui.fromHandle(_obj_newObject("label"));
    obj.label46:setParent(obj.scrollBox6);
    obj.label46:setLeft(555);
    obj.label46:setTop(400);
    obj.label46:setWidth(200);
    obj.label46:setHeight(20);
    obj.label46:setText("Conheça as Mesas:");
    obj.label46:setName("label46");
    obj.label46:setFontColor("white");

    obj.button13 = gui.fromHandle(_obj_newObject("button"));
    obj.button13:setParent(obj.scrollBox6);
    obj.button13:setLeft(555);
    obj.button13:setTop(425);
    obj.button13:setWidth(100);
    obj.button13:setText("RPGmeister");
    obj.button13:setName("button13");

    obj.button14 = gui.fromHandle(_obj_newObject("button"));
    obj.button14:setParent(obj.scrollBox6);
    obj.button14:setLeft(667);
    obj.button14:setTop(425);
    obj.button14:setWidth(125);
    obj.button14:setText("[A] Homebound");
    obj.button14:setName("button14");

    obj._e_event0 = obj.dataLink1:addEventListener("onChange",
        function (self, field, oldValue, newValue)
            if sheet==nil then return end;
                            if sheet.arquetipo ~= nil then
                                sheet.arquetipo_pontos = sheet.arquetipo.custo;
                            end;
                            if sheet.advantages ~= nil then
                                sheet.vantagens_pontos = sheet.advantages.custo;
                            end;
                            if sheet.disadvantages ~= nil then
                                sheet.desvantagens_pontos = sheet.disadvantages.custo;
                            end;
                            if sheet.familiaridades ~= nil then
                                sheet.familiaridade_cultural = sheet.familiaridades.custo;
                            end;
                            if sheet.idiomas ~= nil then
                                sheet.idiomas_pontos = sheet.idiomas.custo;
                            end;
        end, obj);

    obj._e_event1 = obj.dataLink2:addEventListener("onChange",
        function (self, field, oldValue, newValue)
            if sheet == nil then return end;
            								local vel = math.floor(tonumber(sheet.atributos_mod_velocidade) or 0);
            								sheet.dodge = vel + 3;
        end, obj);

    obj._e_event2 = obj.button1:addEventListener("onClick",
        function (self)
            local pop = self:findControlByName("popDetails");
            					
            							if sheet.arquetipo == nil then
            								sheet.arquetipo = {};
            								sheet.arquetipo.title = "Arquétipo";
            							else
            								sheet.arquetipo.title = "Arquétipo";
            							end;
            
            							if pop ~= nil then
            								pop:setNodeObject(sheet.arquetipo);
            								pop:showPopupEx("center", self);
            							elseif sheet.arquetipo == nil then
            								showMessage(sheet.arquetipo);
            							else
            								showMessage("Ops, bug.. nao encontrei o popup para exibir");
            							end;
        end, obj);

    obj._e_event3 = obj.button2:addEventListener("onClick",
        function (self)
            local pop = self:findControlByName("popDetails");
            				
            						if sheet.advantages == nil then
            							sheet.advantages = {};
            							sheet.advantages.title = "Vantagens";
            						else
            							sheet.advantages.title = "Vantagens";
            						end;
            
            						if pop ~= nil then
            							pop:setNodeObject(sheet.advantages);
            							pop:showPopupEx("center", self);
            						elseif sheet.advantages == nil then
            							showMessage(sheet.advantages);
            						else
            							showMessage("Ops, bug.. nao encontrei o popup para exibir");
            						end;
        end, obj);

    obj._e_event4 = obj.button3:addEventListener("onClick",
        function (self)
            local pop = self:findControlByName("popDetails");
            				
            						if sheet.disadvantages == nil then
            							sheet.disadvantages = {};
            							sheet.disadvantages.title = "Desvantagens";
            						else
            							sheet.disadvantages.title = "Desvantagens";
            						end;
            
            						if pop ~= nil then
            							pop:setNodeObject(sheet.disadvantages);
            							pop:showPopupEx("center", self);
            						elseif sheet.disadvantages == nil then
            							showMessage(sheet.disadvantages);
            						else
            							showMessage("Ops, bug.. nao encontrei o popup para exibir");
            						end;
        end, obj);

    obj._e_event5 = obj.button4:addEventListener("onClick",
        function (self)
            local pop = self:findControlByName("popDetails");
            					
            							if sheet.familiaridades == nil then
            								sheet.familiaridades = {};
            								sheet.familiaridades.title = "Familiaridades Culturais";
            							else
            								sheet.familiaridades.title = "Familiaridades Culturais";
            							end;
            
            							if pop ~= nil then
            								pop:setNodeObject(sheet.familiaridades);
            								pop:showPopupEx("center", self);
            							elseif sheet.familiaridades == nil then
            								showMessage(sheet.familiaridades);
            							else
            								showMessage("Ops, bug.. nao encontrei o popup para exibir");
            							end;
        end, obj);

    obj._e_event6 = obj.button5:addEventListener("onClick",
        function (self)
            local pop = self:findControlByName("popDetails");
            					
            							if sheet.idiomas == nil then
            								sheet.idiomas = {};
            								sheet.idiomas.title = "Idiomas";
            							else
            								sheet.idiomas.title = "Idiomas";
            							end;
            
            							if pop ~= nil then
            								pop:setNodeObject(sheet.idiomas);
            								pop:showPopupEx("center", self);
            							elseif sheet.idiomas == nil then
            								showMessage(sheet.idiomas);
            							else
            								showMessage("Ops, bug.. nao encontrei o popup para exibir");
            							end;
        end, obj);

    obj._e_event7 = obj.dataLink5:addEventListener("onChange",
        function (self, field, oldValue, newValue)
            pointCount();
        end, obj);

    obj._e_event8 = obj.dataLink6:addEventListener("onChange",
        function (self, field, oldValue, newValue)
            if sheet==nil then return end;
            
            							local carga = tonumber(sheet.carga) or 0;
            
            							sheet.bc_0 = "Nenhuma (BC): " .. (carga);
            							sheet.bc_1 = "Leve (BCx2): " .. (carga*2);
            							sheet.bc_2 = "Média (BCx3): " .. (carga*3);
            							sheet.bc_3 = "Pesada (BCx6): " .. (carga*6);
            							sheet.bc_4 = "Muito Pesada (BCx10): " .. (carga*10);
        end, obj);

    obj._e_event9 = obj.dataLink7:addEventListener("onChange",
        function (self, field, oldValue, newValue)
            if sheet==nil then return end;
            
            							local velocidade = tonumber(sheet.atributos_mod_velocidade) or 0;
            
            							sheet.db_0 = "DBx1: " .. (velocidade);
            							sheet.db_1 = "DBx0,8: " .. (velocidade*0.8);
            							sheet.db_2 = "DBx0,6: " .. (velocidade*0.6);
            							sheet.db_3 = "DBx0,4: " .. (velocidade*0.4);
            							sheet.db_4 = "DBx0,2: " .. (velocidade*0.2);
        end, obj);

    obj._e_event10 = obj.button6:addEventListener("onClick",
        function (self)
            self.rclSkillsNew:append();
        end, obj);

    obj._e_event11 = obj.rclSkillsNew:addEventListener("onCompare",
        function (self, nodeA, nodeB)
            return utils.compareStringPtBr(nodeA.nome, nodeB.nome);
        end, obj);

    obj._e_event12 = obj.labupperGridMagicBox1:addEventListener("onResize",
        function (self)
            self.upperGridMagicBox1._RecalcSize();
        end, obj);

    obj._e_event13 = obj.labupperGridMagicEditBox1:addEventListener("onResize",
        function (self)
            self.upperGridMagicEditBox1._RecalcSize();
        end, obj);

    obj._e_event14 = obj.dataLink8:addEventListener("onChange",
        function (self, field, oldValue, newValue)
            pointCount();
        end, obj);

    obj._e_event15 = obj.button7:addEventListener("onClick",
        function (self)
            self.rclTech:append();
        end, obj);

    obj._e_event16 = obj.rclTech:addEventListener("onCompare",
        function (self, nodeA, nodeB)
            return utils.compareStringPtBr(nodeA.nome, nodeB.nome);
        end, obj);

    obj._e_event17 = obj.button8:addEventListener("onClick",
        function (self)
            self.rclMagic:append();
        end, obj);

    obj._e_event18 = obj.rclMagic:addEventListener("onCompare",
        function (self, nodeA, nodeB)
            return utils.compareStringPtBr(nodeA.nome, nodeB.nome);
        end, obj);

    obj._e_event19 = obj.button9:addEventListener("onClick",
        function (self)
            self.rclBackpack:append();
        end, obj);

    obj._e_event20 = obj.button10:addEventListener("onClick",
        function (self)
            self.rclEquipments:append();
        end, obj);

    obj._e_event21 = obj.button11:addEventListener("onClick",
        function (self)
            gui.openInBrowser('https://github.com/rrpgfirecast/firecast/blob/master/Plugins/Sheets/Ficha%20GURPS%204E/README.md')
        end, obj);

    obj._e_event22 = obj.button12:addEventListener("onClick",
        function (self)
            gui.openInBrowser('http://www.cin.ufpe.br/~jvdl/Plugins/Ficha%20GURPS%204E/Ficha%20GURPS%204E.rpk')
        end, obj);

    obj._e_event23 = obj.button13:addEventListener("onClick",
        function (self)
            gui.openInBrowser('http://firecast.rrpg.com.br:90/a?a=pagRWEMesaInfo.actInfoMesa&mesaid=64070');
        end, obj);

    obj._e_event24 = obj.button14:addEventListener("onClick",
        function (self)
            gui.openInBrowser('http://firecast.rrpg.com.br:90/a?a=pagRWEMesaInfo.actInfoMesa&mesaid=131156');
        end, obj);

    function obj:_releaseEvents()
        __o_rrpgObjs.removeEventListenerById(self._e_event24);
        __o_rrpgObjs.removeEventListenerById(self._e_event23);
        __o_rrpgObjs.removeEventListenerById(self._e_event22);
        __o_rrpgObjs.removeEventListenerById(self._e_event21);
        __o_rrpgObjs.removeEventListenerById(self._e_event20);
        __o_rrpgObjs.removeEventListenerById(self._e_event19);
        __o_rrpgObjs.removeEventListenerById(self._e_event18);
        __o_rrpgObjs.removeEventListenerById(self._e_event17);
        __o_rrpgObjs.removeEventListenerById(self._e_event16);
        __o_rrpgObjs.removeEventListenerById(self._e_event15);
        __o_rrpgObjs.removeEventListenerById(self._e_event14);
        __o_rrpgObjs.removeEventListenerById(self._e_event13);
        __o_rrpgObjs.removeEventListenerById(self._e_event12);
        __o_rrpgObjs.removeEventListenerById(self._e_event11);
        __o_rrpgObjs.removeEventListenerById(self._e_event10);
        __o_rrpgObjs.removeEventListenerById(self._e_event9);
        __o_rrpgObjs.removeEventListenerById(self._e_event8);
        __o_rrpgObjs.removeEventListenerById(self._e_event7);
        __o_rrpgObjs.removeEventListenerById(self._e_event6);
        __o_rrpgObjs.removeEventListenerById(self._e_event5);
        __o_rrpgObjs.removeEventListenerById(self._e_event4);
        __o_rrpgObjs.removeEventListenerById(self._e_event3);
        __o_rrpgObjs.removeEventListenerById(self._e_event2);
        __o_rrpgObjs.removeEventListenerById(self._e_event1);
        __o_rrpgObjs.removeEventListenerById(self._e_event0);
    end;

    obj._oldLFMDestroy = obj.destroy;

    function obj:destroy() 
        self:_releaseEvents();

        if (self.handle ~= 0) and (self.setNodeDatabase ~= nil) then
          self:setNodeDatabase(nil);
        end;

        if self.linUpperGridCampo1 ~= nil then self.linUpperGridCampo1:destroy(); self.linUpperGridCampo1 = nil; end;
        if self.label14 ~= nil then self.label14:destroy(); self.label14 = nil; end;
        if self.labUpperGridCampo2 ~= nil then self.labUpperGridCampo2:destroy(); self.labUpperGridCampo2 = nil; end;
        if self.fraPoderesLayout ~= nil then self.fraPoderesLayout:destroy(); self.fraPoderesLayout = nil; end;
        if self.edit9 ~= nil then self.edit9:destroy(); self.edit9 = nil; end;
        if self.label40 ~= nil then self.label40:destroy(); self.label40 = nil; end;
        if self.label43 ~= nil then self.label43:destroy(); self.label43 = nil; end;
        if self.dataLink4 ~= nil then self.dataLink4:destroy(); self.dataLink4 = nil; end;
        if self.UpperGridCampo1 ~= nil then self.UpperGridCampo1:destroy(); self.UpperGridCampo1 = nil; end;
        if self.edit29 ~= nil then self.edit29:destroy(); self.edit29 = nil; end;
        if self.image5 ~= nil then self.image5:destroy(); self.image5 = nil; end;
        if self.labUpperGridCampo1 ~= nil then self.labUpperGridCampo1:destroy(); self.labUpperGridCampo1 = nil; end;
        if self.edit28 ~= nil then self.edit28:destroy(); self.edit28 = nil; end;
        if self.label45 ~= nil then self.label45:destroy(); self.label45 = nil; end;
        if self.flowLayout1 ~= nil then self.flowLayout1:destroy(); self.flowLayout1 = nil; end;
        if self.UpperGridCampo4 ~= nil then self.UpperGridCampo4:destroy(); self.UpperGridCampo4 = nil; end;
        if self.flowPart13 ~= nil then self.flowPart13:destroy(); self.flowPart13 = nil; end;
        if self.flowPart1 ~= nil then self.flowPart1:destroy(); self.flowPart1 = nil; end;
        if self.flowLineBreak7 ~= nil then self.flowLineBreak7:destroy(); self.flowLineBreak7 = nil; end;
        if self.button2 ~= nil then self.button2:destroy(); self.button2 = nil; end;
        if self.label22 ~= nil then self.label22:destroy(); self.label22 = nil; end;
        if self.flowLayout5 ~= nil then self.flowLayout5:destroy(); self.flowLayout5 = nil; end;
        if self.label35 ~= nil then self.label35:destroy(); self.label35 = nil; end;
        if self.label13 ~= nil then self.label13:destroy(); self.label13 = nil; end;
        if self.layout8 ~= nil then self.layout8:destroy(); self.layout8 = nil; end;
        if self.label27 ~= nil then self.label27:destroy(); self.label27 = nil; end;
        if self.frmBlank ~= nil then self.frmBlank:destroy(); self.frmBlank = nil; end;
        if self.edtUpperGridCampo5 ~= nil then self.edtUpperGridCampo5:destroy(); self.edtUpperGridCampo5 = nil; end;
        if self.rectangle5 ~= nil then self.rectangle5:destroy(); self.rectangle5 = nil; end;
        if self.flowPart19 ~= nil then self.flowPart19:destroy(); self.flowPart19 = nil; end;
        if self.flowPart16 ~= nil then self.flowPart16:destroy(); self.flowPart16 = nil; end;
        if self.button1 ~= nil then self.button1:destroy(); self.button1 = nil; end;
        if self.label8 ~= nil then self.label8:destroy(); self.label8 = nil; end;
        if self.edit26 ~= nil then self.edit26:destroy(); self.edit26 = nil; end;
        if self.edit11 ~= nil then self.edit11:destroy(); self.edit11 = nil; end;
        if self.edit19 ~= nil then self.edit19:destroy(); self.edit19 = nil; end;
        if self.label31 ~= nil then self.label31:destroy(); self.label31 = nil; end;
        if self.image1 ~= nil then self.image1:destroy(); self.image1 = nil; end;
        if self.layout9 ~= nil then self.layout9:destroy(); self.layout9 = nil; end;
        if self.label34 ~= nil then self.label34:destroy(); self.label34 = nil; end;
        if self.edit5 ~= nil then self.edit5:destroy(); self.edit5 = nil; end;
        if self.label15 ~= nil then self.label15:destroy(); self.label15 = nil; end;
        if self.label41 ~= nil then self.label41:destroy(); self.label41 = nil; end;
        if self.scrollBox2 ~= nil then self.scrollBox2:destroy(); self.scrollBox2 = nil; end;
        if self.tab5 ~= nil then self.tab5:destroy(); self.tab5 = nil; end;
        if self.label12 ~= nil then self.label12:destroy(); self.label12 = nil; end;
        if self.flowLineBreak6 ~= nil then self.flowLineBreak6:destroy(); self.flowLineBreak6 = nil; end;
        if self.fraCaracteristicasLayout ~= nil then self.fraCaracteristicasLayout:destroy(); self.fraCaracteristicasLayout = nil; end;
        if self.labUpperGridCampo5 ~= nil then self.labUpperGridCampo5:destroy(); self.labUpperGridCampo5 = nil; end;
        if self.linUpperGridCampo5 ~= nil then self.linUpperGridCampo5:destroy(); self.linUpperGridCampo5 = nil; end;
        if self.textEditor5 ~= nil then self.textEditor5:destroy(); self.textEditor5 = nil; end;
        if self.label16 ~= nil then self.label16:destroy(); self.label16 = nil; end;
        if self.flowPart20 ~= nil then self.flowPart20:destroy(); self.flowPart20 = nil; end;
        if self.textEditor7 ~= nil then self.textEditor7:destroy(); self.textEditor7 = nil; end;
        if self.edit10 ~= nil then self.edit10:destroy(); self.edit10 = nil; end;
        if self.edit16 ~= nil then self.edit16:destroy(); self.edit16 = nil; end;
        if self.edit1 ~= nil then self.edit1:destroy(); self.edit1 = nil; end;
        if self.button4 ~= nil then self.button4:destroy(); self.button4 = nil; end;
        if self.textEditor4 ~= nil then self.textEditor4:destroy(); self.textEditor4 = nil; end;
        if self.label1 ~= nil then self.label1:destroy(); self.label1 = nil; end;
        if self.layout4 ~= nil then self.layout4:destroy(); self.layout4 = nil; end;
        if self.rectangle7 ~= nil then self.rectangle7:destroy(); self.rectangle7 = nil; end;
        if self.button7 ~= nil then self.button7:destroy(); self.button7 = nil; end;
        if self.image3 ~= nil then self.image3:destroy(); self.image3 = nil; end;
        if self.fraUpperGridCaracteristicas ~= nil then self.fraUpperGridCaracteristicas:destroy(); self.fraUpperGridCaracteristicas = nil; end;
        if self.flowLineBreak5 ~= nil then self.flowLineBreak5:destroy(); self.flowLineBreak5 = nil; end;
        if self.flowPart22 ~= nil then self.flowPart22:destroy(); self.flowPart22 = nil; end;
        if self.flowPart5 ~= nil then self.flowPart5:destroy(); self.flowPart5 = nil; end;
        if self.flowPart9 ~= nil then self.flowPart9:destroy(); self.flowPart9 = nil; end;
        if self.layout5 ~= nil then self.layout5:destroy(); self.layout5 = nil; end;
        if self.edit23 ~= nil then self.edit23:destroy(); self.edit23 = nil; end;
        if self.edtUpperGridCampo3 ~= nil then self.edtUpperGridCampo3:destroy(); self.edtUpperGridCampo3 = nil; end;
        if self.dataLink3 ~= nil then self.dataLink3:destroy(); self.dataLink3 = nil; end;
        if self.label29 ~= nil then self.label29:destroy(); self.label29 = nil; end;
        if self.dataLink7 ~= nil then self.dataLink7:destroy(); self.dataLink7 = nil; end;
        if self.rectangle2 ~= nil then self.rectangle2:destroy(); self.rectangle2 = nil; end;
        if self.UpperGridCampo3 ~= nil then self.UpperGridCampo3:destroy(); self.UpperGridCampo3 = nil; end;
        if self.frmTemplateCreditos ~= nil then self.frmTemplateCreditos:destroy(); self.frmTemplateCreditos = nil; end;
        if self.rectangle6 ~= nil then self.rectangle6:destroy(); self.rectangle6 = nil; end;
        if self.label21 ~= nil then self.label21:destroy(); self.label21 = nil; end;
        if self.flowPart6 ~= nil then self.flowPart6:destroy(); self.flowPart6 = nil; end;
        if self.dataLink6 ~= nil then self.dataLink6:destroy(); self.dataLink6 = nil; end;
        if self.label30 ~= nil then self.label30:destroy(); self.label30 = nil; end;
        if self.dataLink2 ~= nil then self.dataLink2:destroy(); self.dataLink2 = nil; end;
        if self.linUpperGridCampo2 ~= nil then self.linUpperGridCampo2:destroy(); self.linUpperGridCampo2 = nil; end;
        if self.textEditor6 ~= nil then self.textEditor6:destroy(); self.textEditor6 = nil; end;
        if self.label19 ~= nil then self.label19:destroy(); self.label19 = nil; end;
        if self.flowLineBreak11 ~= nil then self.flowLineBreak11:destroy(); self.flowLineBreak11 = nil; end;
        if self.richEdit1 ~= nil then self.richEdit1:destroy(); self.richEdit1 = nil; end;
        if self.rclTech ~= nil then self.rclTech:destroy(); self.rclTech = nil; end;
        if self.scrollBox3 ~= nil then self.scrollBox3:destroy(); self.scrollBox3 = nil; end;
        if self.textEditor1 ~= nil then self.textEditor1:destroy(); self.textEditor1 = nil; end;
        if self.flowLayout6 ~= nil then self.flowLayout6:destroy(); self.flowLayout6 = nil; end;
        if self.button9 ~= nil then self.button9:destroy(); self.button9 = nil; end;
        if self.pgcPrincipal ~= nil then self.pgcPrincipal:destroy(); self.pgcPrincipal = nil; end;
        if self.edit6 ~= nil then self.edit6:destroy(); self.edit6 = nil; end;
        if self.linUpperGridCampo4 ~= nil then self.linUpperGridCampo4:destroy(); self.linUpperGridCampo4 = nil; end;
        if self.label18 ~= nil then self.label18:destroy(); self.label18 = nil; end;
        if self.label2 ~= nil then self.label2:destroy(); self.label2 = nil; end;
        if self.textEditor8 ~= nil then self.textEditor8:destroy(); self.textEditor8 = nil; end;
        if self.edit3 ~= nil then self.edit3:destroy(); self.edit3 = nil; end;
        if self.upperGridMagicBox1 ~= nil then self.upperGridMagicBox1:destroy(); self.upperGridMagicBox1 = nil; end;
        if self.label38 ~= nil then self.label38:destroy(); self.label38 = nil; end;
        if self.panupperGridMagicBox1 ~= nil then self.panupperGridMagicBox1:destroy(); self.panupperGridMagicBox1 = nil; end;
        if self.panupperGridMagicEditBox1 ~= nil then self.panupperGridMagicEditBox1:destroy(); self.panupperGridMagicEditBox1 = nil; end;
        if self.edit27 ~= nil then self.edit27:destroy(); self.edit27 = nil; end;
        if self.scrollBox5 ~= nil then self.scrollBox5:destroy(); self.scrollBox5 = nil; end;
        if self.UpperGridCampo6 ~= nil then self.UpperGridCampo6:destroy(); self.UpperGridCampo6 = nil; end;
        if self.edit18 ~= nil then self.edit18:destroy(); self.edit18 = nil; end;
        if self.flowLineBreak2 ~= nil then self.flowLineBreak2:destroy(); self.flowLineBreak2 = nil; end;
        if self.edit25 ~= nil then self.edit25:destroy(); self.edit25 = nil; end;
        if self.rclSkillsNew ~= nil then self.rclSkillsNew:destroy(); self.rclSkillsNew = nil; end;
        if self.scrollBox1 ~= nil then self.scrollBox1:destroy(); self.scrollBox1 = nil; end;
        if self.flowPart15 ~= nil then self.flowPart15:destroy(); self.flowPart15 = nil; end;
        if self.flowLayout8 ~= nil then self.flowLayout8:destroy(); self.flowLayout8 = nil; end;
        if self.edtUpperGridCampo4 ~= nil then self.edtUpperGridCampo4:destroy(); self.edtUpperGridCampo4 = nil; end;
        if self.UpperGridCampo5 ~= nil then self.UpperGridCampo5:destroy(); self.UpperGridCampo5 = nil; end;
        if self.layout7 ~= nil then self.layout7:destroy(); self.layout7 = nil; end;
        if self.rclBackpack ~= nil then self.rclBackpack:destroy(); self.rclBackpack = nil; end;
        if self.label33 ~= nil then self.label33:destroy(); self.label33 = nil; end;
        if self.tab6 ~= nil then self.tab6:destroy(); self.tab6 = nil; end;
        if self.flowPart14 ~= nil then self.flowPart14:destroy(); self.flowPart14 = nil; end;
        if self.flowPart8 ~= nil then self.flowPart8:destroy(); self.flowPart8 = nil; end;
        if self.labupperGridMagicBox1 ~= nil then self.labupperGridMagicBox1:destroy(); self.labupperGridMagicBox1 = nil; end;
        if self.tab3 ~= nil then self.tab3:destroy(); self.tab3 = nil; end;
        if self.flowLineBreak9 ~= nil then self.flowLineBreak9:destroy(); self.flowLineBreak9 = nil; end;
        if self.flowPart10 ~= nil then self.flowPart10:destroy(); self.flowPart10 = nil; end;
        if self.upperGridMagicEditBox1 ~= nil then self.upperGridMagicEditBox1:destroy(); self.upperGridMagicEditBox1 = nil; end;
        if self.label44 ~= nil then self.label44:destroy(); self.label44 = nil; end;
        if self.popPower ~= nil then self.popPower:destroy(); self.popPower = nil; end;
        if self.flowLayout3 ~= nil then self.flowLayout3:destroy(); self.flowLayout3 = nil; end;
        if self.edit7 ~= nil then self.edit7:destroy(); self.edit7 = nil; end;
        if self.flowPart7 ~= nil then self.flowPart7:destroy(); self.flowPart7 = nil; end;
        if self.textEditor3 ~= nil then self.textEditor3:destroy(); self.textEditor3 = nil; end;
        if self.edit12 ~= nil then self.edit12:destroy(); self.edit12 = nil; end;
        if self.label26 ~= nil then self.label26:destroy(); self.label26 = nil; end;
        if self.label23 ~= nil then self.label23:destroy(); self.label23 = nil; end;
        if self.edtUpperGridCampo2 ~= nil then self.edtUpperGridCampo2:destroy(); self.edtUpperGridCampo2 = nil; end;
        if self.flowPart2 ~= nil then self.flowPart2:destroy(); self.flowPart2 = nil; end;
        if self.label32 ~= nil then self.label32:destroy(); self.label32 = nil; end;
        if self.image2 ~= nil then self.image2:destroy(); self.image2 = nil; end;
        if self.label24 ~= nil then self.label24:destroy(); self.label24 = nil; end;
        if self.layout3 ~= nil then self.layout3:destroy(); self.layout3 = nil; end;
        if self.dataLink5 ~= nil then self.dataLink5:destroy(); self.dataLink5 = nil; end;
        if self.flowPart18 ~= nil then self.flowPart18:destroy(); self.flowPart18 = nil; end;
        if self.layout1 ~= nil then self.layout1:destroy(); self.layout1 = nil; end;
        if self.tab2 ~= nil then self.tab2:destroy(); self.tab2 = nil; end;
        if self.rectangle1 ~= nil then self.rectangle1:destroy(); self.rectangle1 = nil; end;
        if self.edit24 ~= nil then self.edit24:destroy(); self.edit24 = nil; end;
        if self.rclEquipments ~= nil then self.rclEquipments:destroy(); self.rclEquipments = nil; end;
        if self.edit14 ~= nil then self.edit14:destroy(); self.edit14 = nil; end;
        if self.dataLink8 ~= nil then self.dataLink8:destroy(); self.dataLink8 = nil; end;
        if self.edit4 ~= nil then self.edit4:destroy(); self.edit4 = nil; end;
        if self.fraFrenteLayoutNew ~= nil then self.fraFrenteLayoutNew:destroy(); self.fraFrenteLayoutNew = nil; end;
        if self.label4 ~= nil then self.label4:destroy(); self.label4 = nil; end;
        if self.label6 ~= nil then self.label6:destroy(); self.label6 = nil; end;
        if self.button13 ~= nil then self.button13:destroy(); self.button13 = nil; end;
        if self.textEditor2 ~= nil then self.textEditor2:destroy(); self.textEditor2 = nil; end;
        if self.flowPart12 ~= nil then self.flowPart12:destroy(); self.flowPart12 = nil; end;
        if self.label37 ~= nil then self.label37:destroy(); self.label37 = nil; end;
        if self.edit8 ~= nil then self.edit8:destroy(); self.edit8 = nil; end;
        if self.flowLayout7 ~= nil then self.flowLayout7:destroy(); self.flowLayout7 = nil; end;
        if self.flowPart4 ~= nil then self.flowPart4:destroy(); self.flowPart4 = nil; end;
        if self.flowLayout9 ~= nil then self.flowLayout9:destroy(); self.flowLayout9 = nil; end;
        if self.edit2 ~= nil then self.edit2:destroy(); self.edit2 = nil; end;
        if self.label28 ~= nil then self.label28:destroy(); self.label28 = nil; end;
        if self.label9 ~= nil then self.label9:destroy(); self.label9 = nil; end;
        if self.flowLineBreak1 ~= nil then self.flowLineBreak1:destroy(); self.flowLineBreak1 = nil; end;
        if self.edit21 ~= nil then self.edit21:destroy(); self.edit21 = nil; end;
        if self.tab4 ~= nil then self.tab4:destroy(); self.tab4 = nil; end;
        if self.button3 ~= nil then self.button3:destroy(); self.button3 = nil; end;
        if self.label42 ~= nil then self.label42:destroy(); self.label42 = nil; end;
        if self.labUpperGridCampo4 ~= nil then self.labUpperGridCampo4:destroy(); self.labUpperGridCampo4 = nil; end;
        if self.labUpperGridCampo3 ~= nil then self.labUpperGridCampo3:destroy(); self.labUpperGridCampo3 = nil; end;
        if self.flowLineBreak3 ~= nil then self.flowLineBreak3:destroy(); self.flowLineBreak3 = nil; end;
        if self.label17 ~= nil then self.label17:destroy(); self.label17 = nil; end;
        if self.flowLayout4 ~= nil then self.flowLayout4:destroy(); self.flowLayout4 = nil; end;
        if self.edit13 ~= nil then self.edit13:destroy(); self.edit13 = nil; end;
        if self.flowPart11 ~= nil then self.flowPart11:destroy(); self.flowPart11 = nil; end;
        if self.dataLink1 ~= nil then self.dataLink1:destroy(); self.dataLink1 = nil; end;
        if self.button11 ~= nil then self.button11:destroy(); self.button11 = nil; end;
        if self.popDetails ~= nil then self.popDetails:destroy(); self.popDetails = nil; end;
        if self.button12 ~= nil then self.button12:destroy(); self.button12 = nil; end;
        if self.button6 ~= nil then self.button6:destroy(); self.button6 = nil; end;
        if self.label36 ~= nil then self.label36:destroy(); self.label36 = nil; end;
        if self.button5 ~= nil then self.button5:destroy(); self.button5 = nil; end;
        if self.rectangle3 ~= nil then self.rectangle3:destroy(); self.rectangle3 = nil; end;
        if self.edtUpperGridCampo6 ~= nil then self.edtUpperGridCampo6:destroy(); self.edtUpperGridCampo6 = nil; end;
        if self.flowLayout2 ~= nil then self.flowLayout2:destroy(); self.flowLayout2 = nil; end;
        if self.label10 ~= nil then self.label10:destroy(); self.label10 = nil; end;
        if self.edit17 ~= nil then self.edit17:destroy(); self.edit17 = nil; end;
        if self.labupperGridMagicBox1val ~= nil then self.labupperGridMagicBox1val:destroy(); self.labupperGridMagicBox1val = nil; end;
        if self.layout2 ~= nil then self.layout2:destroy(); self.layout2 = nil; end;
        if self.linUpperGridCampo6 ~= nil then self.linUpperGridCampo6:destroy(); self.linUpperGridCampo6 = nil; end;
        if self.flowLineBreak10 ~= nil then self.flowLineBreak10:destroy(); self.flowLineBreak10 = nil; end;
        if self.labUpperGridCampo6 ~= nil then self.labUpperGridCampo6:destroy(); self.labUpperGridCampo6 = nil; end;
        if self.flowPart17 ~= nil then self.flowPart17:destroy(); self.flowPart17 = nil; end;
        if self.button10 ~= nil then self.button10:destroy(); self.button10 = nil; end;
        if self.flowLineBreak8 ~= nil then self.flowLineBreak8:destroy(); self.flowLineBreak8 = nil; end;
        if self.scrollBox6 ~= nil then self.scrollBox6:destroy(); self.scrollBox6 = nil; end;
        if self.label39 ~= nil then self.label39:destroy(); self.label39 = nil; end;
        if self.flowPart3 ~= nil then self.flowPart3:destroy(); self.flowPart3 = nil; end;
        if self.label46 ~= nil then self.label46:destroy(); self.label46 = nil; end;
        if self.edit15 ~= nil then self.edit15:destroy(); self.edit15 = nil; end;
        if self.label11 ~= nil then self.label11:destroy(); self.label11 = nil; end;
        if self.label3 ~= nil then self.label3:destroy(); self.label3 = nil; end;
        if self.label20 ~= nil then self.label20:destroy(); self.label20 = nil; end;
        if self.labupperGridMagicEditBox1 ~= nil then self.labupperGridMagicEditBox1:destroy(); self.labupperGridMagicEditBox1 = nil; end;
        if self.UpperGridCampo2 ~= nil then self.UpperGridCampo2:destroy(); self.UpperGridCampo2 = nil; end;
        if self.label25 ~= nil then self.label25:destroy(); self.label25 = nil; end;
        if self.label7 ~= nil then self.label7:destroy(); self.label7 = nil; end;
        if self.button8 ~= nil then self.button8:destroy(); self.button8 = nil; end;
        if self.linUpperGridCampo3 ~= nil then self.linUpperGridCampo3:destroy(); self.linUpperGridCampo3 = nil; end;
        if self.flowPart21 ~= nil then self.flowPart21:destroy(); self.flowPart21 = nil; end;
        if self.edit22 ~= nil then self.edit22:destroy(); self.edit22 = nil; end;
        if self.rclMagic ~= nil then self.rclMagic:destroy(); self.rclMagic = nil; end;
        if self.label5 ~= nil then self.label5:destroy(); self.label5 = nil; end;
        if self.layout6 ~= nil then self.layout6:destroy(); self.layout6 = nil; end;
        if self.scrollBox4 ~= nil then self.scrollBox4:destroy(); self.scrollBox4 = nil; end;
        if self.rectangle4 ~= nil then self.rectangle4:destroy(); self.rectangle4 = nil; end;
        if self.fraInventarioLayout ~= nil then self.fraInventarioLayout:destroy(); self.fraInventarioLayout = nil; end;
        if self.image4 ~= nil then self.image4:destroy(); self.image4 = nil; end;
        if self.button14 ~= nil then self.button14:destroy(); self.button14 = nil; end;
        if self.tab1 ~= nil then self.tab1:destroy(); self.tab1 = nil; end;
        if self.flowLineBreak4 ~= nil then self.flowLineBreak4:destroy(); self.flowLineBreak4 = nil; end;
        if self.edtupperGridMagicEditBox1 ~= nil then self.edtupperGridMagicEditBox1:destroy(); self.edtupperGridMagicEditBox1 = nil; end;
        if self.edtUpperGridCampo1 ~= nil then self.edtUpperGridCampo1:destroy(); self.edtUpperGridCampo1 = nil; end;
        if self.edit20 ~= nil then self.edit20:destroy(); self.edit20 = nil; end;
        self:_oldLFMDestroy();
    end;

    obj:endUpdate();

     __o_rrpgObjs.endObjectsLoading();

    return obj;
end;

local _frmTemplate = {
    newEditor = newfrmTemplate, 
    new = newfrmTemplate, 
    name = "frmTemplate", 
    dataType = "Ambesek.Nefertyne.GURPS", 
    formType = "sheetTemplate", 
    formComponentName = "form", 
    title = "Ficha GURPS 4E", 
    description=""};

frmTemplate = _frmTemplate;
rrpg.registrarForm(_frmTemplate);
rrpg.registrarDataType(_frmTemplate);

return _frmTemplate;