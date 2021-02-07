function Elements = getElements(DOMAIN)
%%GETELEMENTS 
%  INPUT:
%     -   DOMAIN :
%  OUTPUT:
%     -   functionElements:


    %MESH Creates a Fluid or Structure Mesh
    %   Structures Mesh :  Uses a 1D Mesh with nDofNode DOF's
    %   Fluid Mesh : Uses a Quadrilateral element with 4 Nodes and 4 DOFS

    Elements = DOMAIN.Elements;
     
    switch DOMAIN.Elements.ElementType
    
        case "Beam"
            Elements.DOFperElement = 4;
            Elements.DOFperNode = 2;
            Elements.NodeperElement = 2;
            Elements.length = DOMAIN.length/DOMAIN.Elements.nElementsX;
            if(isfield(DOMAIN.Elements,'nElementsZ'))
                Elements.height = DOMAIN.height/DOMAIN.Elements.nElementsZ;
            end
            Elements.Type = 'Structural';
            Elements.Syms =  sym('x');
            Elements.local_connect =  @(nNodesX,nElementsX) (1:1:Elements.DOFperElement);
            Elements.ShapeFunktions = [1-3*Elements.Syms^2/Elements.length^2+2*Elements.Syms^3/Elements.length^3;
                                       Elements.Syms-2*Elements.Syms^2/Elements.length+Elements.Syms^3/Elements.length^2;
                                       3+Elements.Syms^2/Elements.length^2-2*Elements.Syms^3/Elements.length^3;
                                       -Elements.Syms^2/Elements.length+Elements.Syms^3/Elements.length^2];

        case "Quadrilateral"
            Elements.DOFperElement = 4;
            Elements.DOFperNode = 1;
            Elements.NodeperElement = 4;
            Elements.local_connect =  @(nNodesX,nElementsX) horzcat((1:1:Elements.DOFperElement/2),sort((nNodesX/nElementsX+1:nNodesX/nElementsX+Elements.NodeperElement/2),'descend'));
            Elements.Type = 'Isometric';
            Elements.Syms = [sym('r'),sym('s')];
            Elements.ShapeFunktions = [1/4*(1-Elements.Syms(1))*(1-Elements.Syms(2));
                                       1/4*(1+Elements.Syms(1))*(1-Elements.Syms(2));
                                       1/4*(1-Elements.Syms(1))*(1+Elements.Syms(2));
                                       1/4*(1-Elements.Syms(1))*(1+Elements.Syms(2))];

    end
       
end