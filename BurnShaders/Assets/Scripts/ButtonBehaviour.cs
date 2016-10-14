using UnityEngine;
using UnityEngine.UI;
using System.Linq;
using System.Collections;

namespace BurnShaders
{
    public class ButtonBehaviour : MonoBehaviour
    {
        public Button[] buttons;
        public Sprite selectedSprite;

        void Start()
        {
            SetSelectedButon(0);
        }

        public void SetSelectedButon(int selectedIndex)
        {
            for (int i = 0; i < buttons.Length; i++)
            {
                if (i == selectedIndex)
                    buttons[i].image.overrideSprite = selectedSprite;
                else
                    buttons[i].image.overrideSprite = null;
            }
        }
    }

}
