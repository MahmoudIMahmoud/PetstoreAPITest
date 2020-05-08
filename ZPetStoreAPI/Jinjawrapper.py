from jinja2 import Template
def Render_The_Template(template,**dataDict):
    tm = Template(template)
    return tm.render(dataDict)
    