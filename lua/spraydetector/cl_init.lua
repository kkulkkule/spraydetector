HSSprayDetector = {}
Msg("##############################\n")
Msg("## Loading Spray Detector   ##\n")
-- Msg("## shared.lua               ##\n")
Msg("##############################\n")

HSSprayDetector.List = {}
function HSSprayDetector.ReceiveList(len)
	local tbl = net.ReadTable()
	if !tbl or !istable(tbl) then
		return
	end
	HSSprayDetector.List = tbl
end
net.Receive("hssd_list", HSSprayDetector.ReceiveList)

function HSSprayDetector.DrawInfo(depth, skybox)
	if !istable(HSSprayDetector.List) then
		return
	end
	if table.Count(HSSprayDetector.List) <= 0 then
		return
	end
	for i, v in pairs(HSSprayDetector.List) do
		local sid, nick, pos, ang = i, v[1], v[2], v[3]
		local dist = pos:Distance(LocalPlayer():EyePos())
		if dist > 300 then
			continue
		end
		if !(sid or nick or pos or ang) then
			continue
		end
		-- cam.IgnoreZ(true)
		cam.Start3D2D(pos, ang, 0.1)
			draw.SimpleText("닉네임: " .. nick, "ChatFont", 0, 180, Color(0, 255, 0, math.Clamp(220 - 220 * (dist / 300), 0, 220)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("SID: " .. sid, "ChatFont", 0, 210, Color(0, 255, 0, math.Clamp(220 - 220 * (dist / 300), 0, 220)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		cam.End3D2D()
		-- cam.IgnoreZ(false)
	end
end
hook.Add("PostDrawTranslucentRenderables", "HSSprayDetector.DrawInfo", HSSprayDetector.DrawInfo)